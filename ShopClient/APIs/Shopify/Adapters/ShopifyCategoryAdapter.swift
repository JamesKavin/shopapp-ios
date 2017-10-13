//
//  ShopifyCategoryAdapter.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 10/12/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import MobileBuySDK

extension Storefront.Collection: CategoryEntityInterface {
    var entityId: String {
        get {
            return id.rawValue
        }
    }
    
    var entityTitle: String? {
        get {
            return title
        }
    }
    
    var entityCategoryDescription: String? {
        get {
            return description
        }
    }
    
    var entityAdditionalDescription: String? {
        get {
            return descriptionHtml
        }
    }
    
    var entityUpdatedAt: Date? {
        get {
            return updatedAt
        }
    }
    
    var entityImage: ImageEntityInterface? {
        get {
            return image
        }
    }
        
    var entityPaginationValue: Any? {
        get {
            return nil
        }
    }
    
    var entityProducts: [ProductEntityInterface]? {
        get {
            return products.edges.map({ $0.node })
        }
    }
}
