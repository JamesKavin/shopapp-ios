//
//  AccountAddressFormViewControllerSpec.swift
//  ShopAppTests
//
//  Created by Evgeniy Antonov on 2/28/18.
//  Copyright © 2018 RubyGarage. All rights reserved.
//

import Nimble
import Quick

import ShopApp_Gateway

@testable import ShopApp

class AccountAddressFormViewControllerSpec: QuickSpec {
    override func spec() {
        var viewController: AccountAddressFormViewController!
        var viewModelMock: AccountAddressFormViewModelMock!
        var viewControllerDelegateMock: AccountAddressFormControllerDelegateMock!
        
        beforeEach {
            viewController = UIStoryboard(name: StoryboardNames.account, bundle: nil).instantiateViewController(withIdentifier: ControllerIdentifiers.accountAddressForm) as! AccountAddressFormViewController
            
            let repositoryMock = CustomerRepositoryMock()
            let addAddressUseCaseMock = AddAddressUseCaseMock(repository: repositoryMock)
            let updateAddressUseCaseMock = UpdateAddressUseCaseMock(repository: repositoryMock)
            viewModelMock = AccountAddressFormViewModelMock(addAddressUseCase: addAddressUseCaseMock, updateAddressUseCase: updateAddressUseCaseMock)
            viewController.viewModel = viewModelMock
            
            viewControllerDelegateMock = AccountAddressFormControllerDelegateMock()
            viewController.delegate = viewControllerDelegateMock
        }
        
        describe("when view loaded") {
            beforeEach {
                viewController.selectedAddress = Address()
                _ = viewController.view
            }
            
            it("should have a correct view model type") {
                expect(viewController.viewModel).to(beAKindOf(AccountAddressFormViewModel.self))
            }
        }
        
        describe("when child controller did set") {
            context("if action is add") {
                beforeEach {
                    viewController.selectedAddress = nil
                    _ = viewController.view
                }
                
                it("should have correct child controller properties") {
                    let childController = viewController.childViewControllers.first as? AddressFormViewController
                    expect(childController?.address).to(beNil())
                }
            }
            
            context("if action is edit") {
                beforeEach {
                    viewController.selectedAddress = Address()
                    _ = viewController.view
                }
                
                it("should have correct child controller properties") {
                    let childController = viewController.childViewControllers.first as? AddressFormViewController
                    expect(childController?.address) === viewController.selectedAddress
                }
            }
        }
        
        describe("when filled address did set") {
            var address: Address!
            
            beforeEach {
                address = Address()
            }
            
            context("if address did add") {
                beforeEach {
                    viewController.addressAction = .add
                    _ = viewController.view
                }
                
                it("should add address") {
                    viewModelMock.addCustomerAddress(with: address)
                    
                    expect(viewControllerDelegateMock.addedAddress) === address
                }
            }
            
            context("if address did update") {
                beforeEach {
                    viewController.addressAction = .edit
                    _ = viewController.view
                }
                
                it("should update address") {
                    viewModelMock.updateCustomerAddress(with: address)
                    
                    expect(viewControllerDelegateMock.updatedAddress) === address
                }
            }
        }
    }
}
