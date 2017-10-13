//
//  CategoryModelHelper.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 10/13/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

extension Category {
    var productsArray: [Product]? {
        get {
            return products?.allObjects as? [Product]
        }
    }
}
