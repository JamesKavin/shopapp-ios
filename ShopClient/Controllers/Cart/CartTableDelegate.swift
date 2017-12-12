//
//  CartTableDelegate.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 11/20/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import UIKit

protocol CartTableDelegateProtocol {
    func itemsCount() -> Int
    func totalPrice() -> Float
    func currency() -> String
}

class CartTableDelegate: NSObject, UITableViewDelegate {
    var delegate: CartTableDelegateProtocol?
    
    init(delegate: CartTableDelegateProtocol?) {
        super.init()
        
        self.delegate = delegate
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let productsCount = delegate?.itemsCount() ?? 0
        let totalPrice: Float = delegate?.totalPrice() ?? 0
        let currency = delegate?.currency() ?? String()
        
        return CartHeaderView(productsCounts: productsCount, totalPrice: totalPrice, currency: currency)
    }
}
