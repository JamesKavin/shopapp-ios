//
//  GridCollectionViewCell.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 9/1/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import UIKit

private let kNumberOfColumns: CGFloat = 2
private let kCollectionViewMargin: CGFloat = 7
private let kCellRatio: CGFloat = 210 / 185

class GridCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    public func configure(with item: Product) {
        productImageView.set(image: item.images?.first)
        titleLabel.text = item.title
        let formatter = NumberFormatter.formatter(with: item.currency!)
        let localizedString = "Label.PriceFrom".localizable
        let price = NSDecimalNumber(string: item.lowestPrice)
        priceLabel.text = String.localizedStringWithFormat(localizedString, formatter.string(from: price)!)
    }
}

extension GridCollectionViewCell {
    class var cellSize: CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        let collectionViewWidth = screenWidth - 2 * kCollectionViewMargin
        let cellWidth = collectionViewWidth / kNumberOfColumns
        let cellHeight = Float(cellWidth * kCellRatio)
        let roundedCellheight = CGFloat(lroundf(cellHeight))
        return CGSize(width: cellWidth, height: roundedCellheight)
    }
    
    class var collectionViewInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: kCollectionViewMargin, bottom: 0, right: kCollectionViewMargin)
    }
}
