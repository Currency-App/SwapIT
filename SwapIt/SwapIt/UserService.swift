//
//  UserService.swift
//  SwapIt
//
//  Created by Grace Leung on 5/7/20.
//  Copyright © 2020 FONZIES_LAB. All rights reserved.
//

import Foundation
import Firebase


class UserService {
    static var currentUserProfile:User?
    
    static func observeUserProfile(_ uid: String, completion: @escaping ((_ userProfile:User?)-> ())){
        let userRef = Database.database().reference().child("users\(uid)")
        
        userRef.observe(.value, with: { snapshot in
            var userProfile:User?
            
            if let dictionary = snapshot.value as? [String: AnyObject],
                let firstName = dictionary["firstName"] as? String,
                let lastName = dictionary["lastName"] as? String,
                let email = dictionary["email"] as? String
            {
                userProfile = User(id: snapshot.key, firstName: firstName, lastName: lastName, email: email)
            }
            completion(userProfile)
            
        })
    }
}
