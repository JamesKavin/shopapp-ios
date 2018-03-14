//
//  HomeTableProviderDelegateMock.swift
//  ShopAppTests
//
//  Created by Evgeniy Antonov on 3/13/18.
//  Copyright © 2018 RubyGarage. All rights reserved.
//

import UIKit

import ShopApp_Gateway

@testable import ShopApp

class HomeTableProviderDelegateMock: NSObject, HomeTableProviderDelegate, LastArrivalsTableCellDelegate, PopularTableCellDelegate, SeeAllHeaderViewProtocol {
    var provider: HomeTableProvider?
    var article: Article?
    
    // MARK: - HomeTableProviderDelegate
    
    func provider(_ provider: HomeTableProvider, didSelect article: Article) {
        self.provider = provider
        self.article = article
    }
    
    // MARK: - LastArrivalsTableCellDelegate
    
    func tableViewCell(_ tableViewCell: LastArrivalsTableViewCell, didSelect product: Product) {}
    
    // MARK: - PopularTableCellDelegate
    
    func tableViewCell(_ tableViewCell: PopularTableViewCell, didSelect product: Product) {}
    
    // MARK: - SeeAllHeaderViewProtocol
    
    func didTapSeeAll(type: SeeAllViewType) {}
}
