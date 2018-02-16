//
//  CustomerUseCase.swift
//  ShopClient
//
//  Created by Radyslav Krechet on 12/27/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import ShopClient_Gateway

struct CustomerUseCase {
    private let repository: Repository!

    init() {
        self.repository = nil
    }

    func getCustomer(_ callback: @escaping RepoCallback<Customer>) {
        repository.getCustomer(callback: callback)
    }
}
