//
//  ShopifyCheckoutAdapter.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 11/20/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import MobileBuySDK

extension Checkout {
    convenience init?(with item: Storefront.Checkout?) {
        if item == nil {
            return nil
        }
        self.init()
        
        id = item?.id.rawValue ?? ""
        webUrl = item?.webUrl.absoluteString
        currencyCode = item?.currencyCode.rawValue
        subtotalPrice = item?.subtotalPrice
        totalPrice = item?.totalPrice
        shippingLine = ShippingRate(with: item?.shippingLine)
        shippingAddress = Address(with: item?.shippingAddress)
        if let nodes = item?.lineItems.edges.map({ $0.node }) {
            var itemsArray = [LineItem]()
            for node in nodes {
                if let lineItem = LineItem(with: node) {
                    itemsArray.append(lineItem)
                }
            }
            lineItems = itemsArray
        }
        if let rates = item?.availableShippingRates?.shippingRates {
            var itemsArray = [ShippingRate]()
            for rate in rates {
                if let rateItem = ShippingRate(with: rate) {
                    itemsArray.append(rateItem)
                }
            }
            availableShippingRates = itemsArray
        }
    }
}
