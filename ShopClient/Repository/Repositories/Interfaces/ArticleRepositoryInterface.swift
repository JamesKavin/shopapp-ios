//
//  ArticleRepositoryInterface.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 10/24/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

protocol ArticleRepositoryInterface {
    func getArticleList(perPage: Int, paginationValue: Any?, sortBy: SortingValue?, reverse: Bool, callback: @escaping RepoCallback<[Article]>)
    func getArticle(id: String, callback: @escaping RepoCallback<Article>)
}
