//
//  StringValidator.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 11/14/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import Foundation

private let kPasswordCharactersCountMin = 6

internal extension String {
    func isValidAsEmais() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidAsPassword() -> Bool {
        return self.characters.count >= kPasswordCharactersCountMin
    }
    
    func orNil() -> String? {
        return self.isEmpty ? nil : self
    }
}
