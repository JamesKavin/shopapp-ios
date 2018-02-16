//
//  ShopRepositoryInterface.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 10/23/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import Foundation

public protocol ShopRepository {
    func getShop(callback: @escaping RepoCallback<Shop>)
}
