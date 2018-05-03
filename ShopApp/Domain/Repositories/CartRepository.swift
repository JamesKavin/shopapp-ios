//
//  CartRepository.swift
//  ShopApp
//
//  Created by Evgeniy Antonov on 11/7/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import ShopApp_Gateway

protocol CartRepository {
    func getCartProductList(callback: @escaping RepoCallback<[CartProduct]>)
    func addCartProduct(cartProduct: CartProduct, callback: @escaping RepoCallback<Bool>)
    func deleteProductFromCart(with productVariantId: String?, callback: @escaping RepoCallback<Bool>)
    func deleteProductsFromCart(with productVariantIds: [String?], callback: @escaping RepoCallback<Bool>)
    func deleteAllProductsFromCart(with callback: @escaping RepoCallback<Bool>)
    func changeCartProductQuantity(with productVariantId: String?, quantity: Int, callback: @escaping RepoCallback<Bool>)
}
