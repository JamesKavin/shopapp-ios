//
//  StoryboardAdditions.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 9/5/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    class func menu() -> UIStoryboard {
        return UIStoryboard(name: "Menu", bundle: nil)
    }
    
    class func productDetails() -> UIStoryboard {
        return UIStoryboard(name: "ProductDetails", bundle: nil)
    }
    
    class func search() -> UIStoryboard {
        return UIStoryboard(name: "Search", bundle: nil)
    }
    
    class func category() -> UIStoryboard {
        return UIStoryboard(name: "Category", bundle: nil)
    }
    
    class func policy() -> UIStoryboard {
        return UIStoryboard(name: "Policy", bundle: nil)
    }
    
    class func lastArrivals() -> UIStoryboard {
        return UIStoryboard(name: "LastArrivals", bundle: nil)
    }
    
    class func imagesCarousel() -> UIStoryboard {
        return UIStoryboard(name: "ImagesCarousel", bundle: nil)
    }
    
    class func articlesList() -> UIStoryboard {
        return UIStoryboard(name: "ArticlesList", bundle: nil)
    }
    
    class func articleDetails() -> UIStoryboard {
        return UIStoryboard(name: "ArticleDetails", bundle: nil)
    }
}
