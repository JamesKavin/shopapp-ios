//
//  ShopRepositoryInterface.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 10/23/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

protocol ShopRepositoryInterface {
    func getShop(callback: @escaping RepoCallback<ShopObject>)
}
