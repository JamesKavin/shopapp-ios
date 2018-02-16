//
//  SignUpUseCase.swift
//  ShopClient
//
//  Created by Radyslav Krechet on 12/28/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import ShopClient_Gateway

struct SignUpUseCase {
    private let repository: Repository!

    init() {
        self.repository = nil
    }

    func signUp(with email: String, firstName: String?, lastName: String?, password: String, phone: String?, _ callback: @escaping RepoCallback<Bool>) {
        repository.signUp(with: email, firstName: firstName, lastName: lastName, password: password, phone: phone, callback: callback)
    }
}
