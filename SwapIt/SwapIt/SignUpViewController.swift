//
//  SignUpViewController.swift
//  SwapIt
//
//  Created by Yao Yu on 4/30/20.
//  Copyright © 2020 FONZIES_LAB. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        let first_name = firstName.text!
        let last_name = lastName.text!
        let Email = email.text!
        let Password = password.text!
        let confirm_passowrd = confirmPassword.text!
        if Password != confirm_passowrd {
        let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: Email, password: Password) { (result, error) in
                if error == nil {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName" : first_name, "lastName": last_name, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                                print("error saving data")
                        }
                    }
                    self.performSegue(withIdentifier: "signUpSuccess", sender: self)

                }
            }
        }
    
              
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
