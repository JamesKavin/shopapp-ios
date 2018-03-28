//
//  APIMock.swift
//  ShopAppTests
//
//  Created by Radyslav Krechet on 3/28/18.
//  Copyright © 2018 RubyGarage. All rights reserved.
//

import ShopApp_Gateway

@testable import ShopApp

class APIMock: API {
    var isNeedToReturnError = false
    var isGetArticleListSterted = false
    var isGetArticleSterted = false
    var perPage: Int?
    var paginationValue: String?
    var sortBy: SortingValue?
    var reverse: Bool?
    var id: String?
    
    // MARK: - Shop
    
    func getShopInfo(callback: @escaping RepoCallback<Shop>) {
        
    }
    
    // MARK: - Products
    
    func getProductList(perPage: Int, paginationValue: Any?, sortBy: SortingValue?, keyPhrase: String?, excludePhrase: String?, reverse: Bool, callback: @escaping RepoCallback<[Product]>) {
        
    }
    
    func getProduct(id: String, callback: @escaping RepoCallback<Product>) {
        
    }
    
    func searchProducts(perPage: Int, paginationValue: Any?, searchQuery: String, callback: @escaping RepoCallback<[Product]>) {
        
    }
    
    // MARK: - Categories
    
    func getCategoryList(perPage: Int, paginationValue: Any?, sortBy: SortingValue?, reverse: Bool, callback: @escaping RepoCallback<[ShopApp_Gateway.Category]>) {
        
    }
    
    func getCategoryDetails(id: String, perPage: Int, paginationValue: Any?, sortBy: SortingValue?, reverse: Bool, callback: @escaping RepoCallback<ShopApp_Gateway.Category>) {
        
    }
    
    // MARK: - Articles
    
    func getArticleList(perPage: Int, paginationValue: Any?, sortBy: SortingValue?, reverse: Bool, callback: @escaping RepoCallback<[Article]>) {
        isGetArticleListSterted = true
        
        self.perPage = perPage
        self.paginationValue = paginationValue as? String
        self.sortBy = sortBy
        self.reverse = reverse
        
        isNeedToReturnError ? callback(nil, RepoError()) : callback([], nil)
    }
    
    func getArticle(id: String, callback: @escaping RepoCallback<(article: Article, baseUrl: URL)>) {
        isGetArticleSterted = true
        
        self.id = id
        
        if isNeedToReturnError {
            callback(nil, RepoError())
        } else {
            let article = Article()
            let baseUrl = URL(string: "https://www.google.com")!
            let result = (article: article, baseUrl: baseUrl)
            
            callback(result, nil)
        }
    }
    
    // MARK: - Authentification
    
    func signUp(with email: String, firstName: String?, lastName: String?, password: String, phone: String?, callback: @escaping RepoCallback<Bool>) {
        
    }
    
    func login(with email: String, password: String, callback: @escaping RepoCallback<Bool>) {
        
    }
    
    func logout(callback: RepoCallback<Bool>) {
        
    }
    
    func isLoggedIn() -> Bool {
        return false
    }
    
    func resetPassword(with email: String, callback: @escaping RepoCallback<Bool>) {
        
    }
    
    // MARK: - Customer
    
    func getCustomer(callback: @escaping RepoCallback<Customer>) {
        
    }
    
    func updateCustomer(with email: String, firstName: String?, lastName: String?, phone: String?, callback: @escaping RepoCallback<Customer>) {
        
    }
    
    func updateCustomer(with promo: Bool, callback: @escaping RepoCallback<Customer>) {
        
    }
    
    func updateCustomer(with password: String, callback: @escaping RepoCallback<Customer>) {
        
    }
    
    func addCustomerAddress(with address: Address, callback: @escaping RepoCallback<String>) {
        
    }
    
    func updateCustomerAddress(with address: Address, callback: @escaping RepoCallback<Bool>) {
        
    }
    
    func updateCustomerDefaultAddress(with addressId: String, callback: @escaping RepoCallback<Customer>) {
        
    }
    
    func deleteCustomerAddress(with addressId: String, callback: @escaping RepoCallback<Bool>) {
        
    }
    
    // MARK: - Payments
    
    func createCheckout(cartProducts: [CartProduct], callback: @escaping RepoCallback<Checkout>) {
        
    }
    
    func getCheckout(with checkoutId: String, callback: @escaping RepoCallback<Checkout>) {
        
    }
    
    func updateShippingAddress(with checkoutId: String, address: Address, callback: @escaping RepoCallback<Bool>) {
        
    }
    
    func getShippingRates(with checkoutId: String, callback: @escaping RepoCallback<[ShippingRate]>) {
        
    }
    
    func updateCheckout(with rate: ShippingRate, checkoutId: String, callback: @escaping RepoCallback<Checkout>) {
        
    }
    
    func pay(with card: CreditCard, checkout: Checkout, billingAddress: Address, customerEmail: String, callback: @escaping RepoCallback<Order>) {
        
    }
    
    func setupApplePay(with checkout: Checkout, customerEmail: String, callback: @escaping RepoCallback<Order>) {
        
    }
    
    func getCountries(callback: @escaping RepoCallback<[Country]>) {
        
    }
    
    // MARK: - Orders
    
    func getOrderList(perPage: Int, paginationValue: Any?, callback: @escaping RepoCallback<[Order]>) {
        
    }
    
    func getOrder(id: String, callback: @escaping RepoCallback<Order>) {
        
    }
}
