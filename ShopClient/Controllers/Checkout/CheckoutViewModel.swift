//
//  CheckoutViewModel.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 12/20/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import RxSwift

enum CheckoutSection: Int {
    case cart
    case shippingAddress
    
    static let allValues = [cart, shippingAddress]
}

class CheckoutViewModel: BaseViewModel {
    var cartItems = [CartProduct]()
    var checkout = Variable<Checkout?>(nil)
    
    public func loadData(with disposeBag: DisposeBag) {
        state.onNext(.loading(showHud: true))
        checkoutSingle.subscribe(onSuccess: { [weak self] (checkout) in
            self?.checkout.value = checkout
            self?.getCustomer()
        }) { [weak self] (error) in
            let castedError = error as? RepoError
            self?.state.onNext(.error(error: castedError))
        }
        .disposed(by: disposeBag)
    }
    
    public func getCheckout() {
        let checkoutId = checkout.value?.id ?? String()
        Repository.shared.getCheckout(with: checkoutId) { [weak self] (result, error) in
            if let error = error {
                self?.state.onNext(.error(error: error))
            }
            if let checkout = result {
                self?.checkout.value = checkout
                self?.state.onNext(.content)
            }
        }
    }
    
    // MARK: - private
    private var cartItemsSingle: Single<[CartProduct]> {
        return Single.create(subscribe: { (event) in
            Repository.shared.getCartProductList(callback: { [weak self] (result, error) in
                if let error = error {
                    event(.error(error))
                }
                if let items = result {
                    self?.cartItems = items
                    event(.success(items))
                }
            })
            return Disposables.create()
        })
    }
    
    private var checkoutSingle: Single<Checkout> {
        return cartItemsSingle.flatMap({ (cartItems) in
            Single.create(subscribe: { (event) in
                Repository.shared.createCheckout(cartProducts: cartItems, callback: { (checkout, error) in
                    if let error = error {
                        event(.error(error))
                    }
                    if let checkout = checkout {
                        event(.success(checkout))
                    }
                })
                return Disposables.create()
            })
        })
    }
    
    private func getCustomer() {
        Repository.shared.getCustomer { [weak self] (customer, error) in
            if let address = customer?.defaultAddress {
                self?.updateCheckoutShippingAddress(with: address)
            } else {
                self?.state.onNext(.content)
            }
        }
    }
    
    private func updateCheckoutShippingAddress(with address: Address) {
        let checkoutId = checkout.value?.id ?? String()
        Repository.shared.updateShippingAddress(with: checkoutId, address: address) { [weak self] (success, error) in
            self?.getCheckout()
        }
    }
}
