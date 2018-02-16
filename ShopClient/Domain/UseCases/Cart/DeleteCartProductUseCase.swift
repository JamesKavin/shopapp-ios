//
//  DeleteCartProductUseCase.swift
//  ShopClient
//
//  Created by Radyslav Krechet on 1/16/18.
//  Copyright © 2018 RubyGarage. All rights reserved.
//

import ShopClient_Gateway

class DeleteCartProductUseCase {
    private lazy var repository = AppDelegate.getCartRepository()
    
    func deleteProductFromCart(productVariantId: String?, _ callback: @escaping RepoCallback<Bool>) {
        repository.deleteProductFromCart(with: productVariantId, callback: callback)
    }
}
