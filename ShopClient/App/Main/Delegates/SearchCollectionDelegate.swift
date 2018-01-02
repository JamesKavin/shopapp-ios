//
//  SearchCollectionDelegate.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 12/19/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import UIKit

protocol SearchCollectionDelegateProtocol {
    func didSelectCategory(at index: Int)
}

class SearchCollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var delegate: SearchCollectionDelegateProtocol?
    
    init(delegate: SearchCollectionDelegateProtocol?) {
        super.init()
        
        self.delegate = delegate
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCategory(at: indexPath.row)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CategoryCollectionViewCell.cellSize
    }
}
