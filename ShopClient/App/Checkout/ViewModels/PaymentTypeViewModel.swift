//
//  PaymentTypeViewModel.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 12/29/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import UIKit

class PaymentTypeViewModel: BaseViewModel {
    private let checkoutUseCase = CheckoutUseCase()
    
    var selectedType: PaymentType?
    var checkout: Checkout!
}
