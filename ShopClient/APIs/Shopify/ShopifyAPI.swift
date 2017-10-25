//
//  ShopifyAPI.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 8/30/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import UIKit
import MobileBuySDK

//let kShopifyStorefrontAccessToken = "afc80014a08846feaf590e1db92e74b6"
//let kShopifyStorefrontURL = "xpohstore.myshopify.com"
//let kShopifyItemsMaxCount: Int32 = 250

class ShopifyAPI: NSObject, ShopAPIProtocol {
    var client: Graph.Client?
    var repository: Repository?
    
    override init() {
        super.init()
        
        setup()
    }
    
    func setup() {
        client = Graph.Client(
            shopDomain: kShopifyStorefrontURL,
            apiKey: kShopifyStorefrontAccessToken
        )
        repository = MagicalRecordRepository()
    }
    
    // MARK: - ShopAPIProtocol
    
    // MARK: - categories
    func getCategoryList(perPage: Int, paginationValue: Any?, sortBy: SortingValue?, reverse: Bool, callback: @escaping ApiCallback<[CategoryEntity]>) {
        let query = categoryListQuery(perPage: perPage, after: paginationValue, sortBy: sortBy, reverse: reverse)
        let task = client?.queryGraphWith(query, completionHandler: { [weak self] (response, error) in
            if let categoryEdges = response?.shop.collections.edges {
                self?.repository?.loadCategories(with: categoryEdges, callback: { (categories, error) in
                    callback(categories, error)
                })
            } else {
                callback([CategoryEntity](), error)
            }
        })
        task?.resume()
    }
    
    func getCategoryDetails(id: String, perPage: Int, paginationValue: Any?, sortBy: SortingValue?, reverse: Bool, callback: @escaping ApiCallback<CategoryEntity>) {
        let query = categoryDetailsQuery(id: id, perPage: perPage, after: paginationValue, sortBy: sortBy, reverse: reverse)
        let task = client?.queryGraphWith(query, completionHandler: { [weak self] (response, error) in
            let categoryNode = response?.node as! Storefront.Collection
            self?.repository?.loadCategory(with: categoryNode, callback: { (category, error) in
                callback(category, error)
            })
        })
        task?.resume()
    }
    
    // MARK: - articles
    func getArticleList(perPage: Int, paginationValue: Any?, sortBy: SortingValue?, reverse: Bool, callback: @escaping ApiCallback<[Article]>) {
        let query = articleListQuery(perPage: perPage, after: paginationValue, reverse: reverse)
        let task = client?.queryGraphWith(query, completionHandler: { (response, error) in
            var articles = [Article]()
            if let articleEdges = response?.shop.articles.edges {
                for articleEdge in articleEdges {
                    articles.append(ShopifyArticleAdapter(article: articleEdge.node, cursor: articleEdge.cursor))
                }
            }
            callback(articles, error)
        })
        task?.resume()
    }
    
    // MARK: - private
    func productSortValue(for key: SortingValue?) -> Storefront.ProductSortKeys? {
        if key == nil {
            return nil
        }
        switch key! {
        case SortingValue.createdAt:
            return Storefront.ProductSortKeys.createdAt
        case SortingValue.name:
            return Storefront.ProductSortKeys.title
        }
    }
    
    func productCollectionSortValue(for key: SortingValue?) -> Storefront.ProductCollectionSortKeys? {
        if key == nil {
            return nil
        }
        switch key! {
        case SortingValue.createdAt:
            return Storefront.ProductCollectionSortKeys.created
        case SortingValue.name:
            return Storefront.ProductCollectionSortKeys.title
        }
    }
    
    // MARK: - queries building
    private func productsListQuery(with perPage: Int, after: Any?, searchPhrase: String?, sortBy: SortingValue?, reverse: Bool) -> Storefront.QueryRootQuery {
        let sortKey = productSortValue(for: sortBy)
        
        return Storefront.buildQuery { $0
            .shop { $0
                .name()
                .products(first: Int32(perPage), after: after as? String, reverse: reverse, sortKey: sortKey, query: searchPhrase, self.productConnectionQuery())
            }
        }
    }
    
    private func productDetailsQuery(id: String, options: [SelectedOption]) -> Storefront.QueryRootQuery {
        let nodeId = GraphQL.ID(rawValue: id)
        return Storefront.buildQuery({ $0
            .node(id: nodeId, { $0
                .onProduct(subfields: self.productQuery(additionalInfoNedded: true, options: options))
            })
        })
    }
    
    private func categoryListQuery(perPage: Int, after: Any?, sortBy: SortingValue?, reverse: Bool) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery({ $0
            .shop({ $0
                .collections(first: Int32(perPage), self.collectionConnectionQuery(perPage: perPage, after: after, sortBy: sortBy, reverse: reverse))
            })
        })
    }
    
    private func categoryDetailsQuery(id: String, perPage: Int, after: Any?, sortBy: SortingValue?, reverse: Bool) -> Storefront.QueryRootQuery {
        let nodeId = GraphQL.ID(rawValue: id)
        return Storefront.buildQuery { $0
            .node(id: nodeId, { $0
                .onCollection(subfields: self.collectionQuery(perPage: perPage, after: after, sortBy: sortBy, reverse: reverse))
            })
        }
    }
    
    private func articleListQuery(perPage: Int, after: Any?, reverse: Bool) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery({ $0
            .shop({ $0
                .articles(first: Int32(perPage), after: after as? String, reverse: reverse, self.articleConnectionQuery())
            })
        })
    }
    
    private func productConnectionQuery() -> ((Storefront.ProductConnectionQuery) -> ()) {
        return { (query: Storefront.ProductConnectionQuery) in
            query.edges({ $0
                .cursor()
                .node(self.productQuery())
            })
        }
    }
    
    private func productQuery(additionalInfoNedded: Bool = false, options: [SelectedOption]? = nil) -> ((Storefront.ProductQuery) -> ()) {
        let imageCount = additionalInfoNedded ? kShopifyItemsMaxCount : 1
        let variantsCount = additionalInfoNedded ? kShopifyItemsMaxCount : 1
        var optionsInput = [Storefront.SelectedOptionInput]()
        if let options = options {
            for option in options {
                optionsInput.append(Storefront.SelectedOptionInput(name: option.name, value: option.value))
            }
        }
        return { (query: Storefront.ProductQuery) in
            query.id()
            query.title()
            query.description()
            query.descriptionHtml()
            query.vendor()
            query.productType()
            query.createdAt()
            query.updatedAt()
            query.tags()
            query.images(first: imageCount, self.imageConnectionQuery())
            query.variants(first: variantsCount, self.variantConnectionQuery())
            query.variantBySelectedOptions(selectedOptions: optionsInput, self.productVariantQuery())
            query.options(self.optionQuery())
        }
    }
    
    private func imageConnectionQuery() -> ((Storefront.ImageConnectionQuery) -> ()) {
        return { (query: Storefront.ImageConnectionQuery) in
            query.edges({ $0
                .node(self.imageQuery())
            })
        }
    }
    
    private func imageQuery() -> ((Storefront.ImageQuery) -> ()) {
        return { (query: Storefront.ImageQuery) in
            query.id()
            query.src()
            query.altText()
        }
    }
    
    private func variantConnectionQuery() -> ((Storefront.ProductVariantConnectionQuery) -> ()) {
        return { (query: Storefront.ProductVariantConnectionQuery) in
            query.edges({ $0
                .node(self.productVariantQuery())
            })
        }
    }
    
    private func productVariantQuery() -> ((Storefront.ProductVariantQuery) -> ()) {
        return { (query: Storefront.ProductVariantQuery) in
            query.id()
            query.title()
            query.price()
            query.availableForSale()
            query.image(self.imageQuery())
        }
    }
    
    private func collectionConnectionQuery(perPage: Int, after: Any?, sortBy: SortingValue?, reverse: Bool) -> ((Storefront.CollectionConnectionQuery) -> ()) {
        return { (query: Storefront.CollectionConnectionQuery) in
            query.edges({ $0
                .cursor()
                .node(self.collectionQuery(perPage: perPage, after: after, sortBy: sortBy, reverse: reverse))
            })
            
        }
    }
    
    private func collectionQuery(perPage: Int = 0, after: Any? = nil, sortBy: SortingValue?, reverse: Bool) -> ((Storefront.CollectionQuery) -> ()) {
        let sortKey = productCollectionSortValue(for: sortBy)
        return { (query: Storefront.CollectionQuery) in
            query.id()
            query.title()
            query.description()
            query.updatedAt()
            query.image(self.imageQuery())
            query.products(first: Int32(perPage), after: after as? String, reverse: reverse, sortKey: sortKey, self.productConnectionQuery())
            if perPage > 0 {
                query.descriptionHtml()
            }
        }
    }
    
    private func policyQuery() -> ((Storefront.ShopPolicyQuery) -> ()) {
        return { (query: Storefront.ShopPolicyQuery) in
            query.title()
            query.body()
            query.url()
        }
    }
    
    private func articleConnectionQuery() -> ((Storefront.ArticleConnectionQuery) -> ()) {
        return { (query: Storefront.ArticleConnectionQuery) in
            query.edges({ $0
                .node(self.articleQuery())
                .cursor()
            })
        }
    }
    
    private func articleQuery() -> ((Storefront.ArticleQuery) -> ()) {
        return { (query: Storefront.ArticleQuery) in
            query.id()
            query.title()
            query.content()
            query.image(self.imageQuery())
            query.author(self.authorQuery())
            query.tags()
            query.blog(self.blogQuery())
            query.publishedAt()
            query.url()
        }
    }
    
    private func authorQuery() -> ((Storefront.ArticleAuthorQuery) -> ()) {
        return { (query: Storefront.ArticleAuthorQuery) in
            query.firstName()
            query.lastName()
            query.name()
            query.email()
            query.bio()
        }
    }
    
    private func blogQuery() -> ((Storefront.BlogQuery) -> ()) {
        return { (query: Storefront.BlogQuery) in
            query.id()
            query.title()
        }
    }
    
    private func optionQuery() -> ((Storefront.ProductOptionQuery) -> ()) {
        return { (query: Storefront.ProductOptionQuery) in
            query.id()
            query.name()
            query.values()
        }
    }
}
