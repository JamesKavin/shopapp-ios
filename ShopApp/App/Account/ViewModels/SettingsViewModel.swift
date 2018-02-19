//
//  SettingsViewModel.swift
//  ShopClient
//
//  Created by Radyslav Krechet on 1/22/18.
//  Copyright © 2018 RubyGarage. All rights reserved.
//

import RxSwift
import ShopApp_Gateway

class SettingsViewModel: BaseViewModel {
    private let loginUseCase = LoginUseCase()
    private let customerUseCase = CustomerUseCase()
    
    private var updateCustomerUseCase: UpdateCustomerUseCase
    
    var customer = Variable<Customer?>(nil)
    
    init(updateCustomerUseCase: UpdateCustomerUseCase) {
        self.updateCustomerUseCase = updateCustomerUseCase
    }
    
    func loadCustomer() {
        loginUseCase.getLoginStatus { isLoggedIn in
            if isLoggedIn {
                getCustomer()
            }
        }
    }
    
    func setPromo(_ value: Bool) {
        guard let customer = customer.value else {
            return
        }
        
        customer.promo = value
        update(customer)
    }
    
    private func getCustomer() {
        state.onNext(ViewState.make.loading())
        customerUseCase.getCustomer { [weak self] (customer, error) in
            guard let strongSelf = self else {
                return
            }
            if let error = error {
                strongSelf.state.onNext(.error(error: error))
            } else if let customer = customer {
                strongSelf.customer.value = customer
                strongSelf.state.onNext(.content)
            }
        }
    }
    
    private func update(_ customer: Customer) {
        state.onNext(ViewState.make.loading(showHud: false))
        updateCustomerUseCase.updateCustomer(with: customer.promo) { [weak self] (customer, error) in
            guard let strongSelf = self else {
                return
            }
            if let error = error {
                strongSelf.state.onNext(.error(error: error))
            } else if customer != nil {
                strongSelf.state.onNext(.content)
            }
        }
    }
}
