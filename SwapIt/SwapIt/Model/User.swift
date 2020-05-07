//
//  User.swift
//  SwapIt
//
//  Created by Alfonso Garibay on 5/3/20.
//  Copyright © 2020 FONZIES_LAB. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    
    init(id: String, firstName: String, lastName: String, email: String)
    {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}
