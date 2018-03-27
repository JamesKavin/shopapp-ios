//
//  AuthentificationRepository.swift
//  ShopApp
//
//  Created by Evgeniy Antonov on 11/10/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import ShopApp_Gateway

protocol AuthentificationRepository {
    func signUp(with email: String, firstName: String?, lastName: String?, password: String, phone: String?, callback: @escaping RepoCallback<Bool>)
    func login(with email: String, password: String, callback: @escaping RepoCallback<Bool>)
    func logout(callback: RepoCallback<Bool>)
    func isLoggedIn() -> Bool
    func resetPassword(with email: String, callback: @escaping RepoCallback<Bool>)
}
