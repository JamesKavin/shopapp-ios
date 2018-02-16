//
//  RepoError+Details.swift
//  ShopClient
//
//  Created by Mykola Voronin on 2/14/18.
//  Copyright © 2018 RubyGarage. All rights reserved.
//

import ShopClient_Gateway

extension RepoError {
    var localizedMessage: String {
        return errorMessage ?? "Error.Unknown".localizable
    }
}
