//
//  MessagesViewController.swift
//  SwapIt
//
//  Created by Nanar Boursalian on 5/1/20.
//  Copyright © 2020 FONZIES_LAB. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UIViewController {

// My text Field
           @IBOutlet weak var textField: UITextField
    
// keyboard behavior: below
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        
        // BELOW IN STRING -> NAME OF A 'NEW MESSAGE ICON' PNG
        let image = UIImage(named: <#T##String#>)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: #selector(handleNewMessage))
        // function is below under firebase attempt 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
        // Hide the keyboard, when uses touches ouside of the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    // hide when the user presses return key
    func textFieldShouldReturn(_textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
}
    // fin keyboard behavior
    
    
// firebase chat attempt 1: below
   
    // here is the button for the new message icon
    func handleNewMessage(){
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        
        presentViewController(navController, animated: true, completion: nil)
    }
    
    // to title page with users name
    let uid = FIRAuth.auth()?.currentUser?.uid
    FIRDatabase.datase().reference().child("users").child(uid!).observeSingleEventOfType(.Value, withBlock: {
    (snapshot) in
    
    if let dictionary = snapshot.value as? [String: AnyObject]{
    self.navigationItem.title = dictionary["firstName"]
    }
    //print(snapshot)
    }, withCancelBlock: nil)
    
    
   
    // fin firebase attempt 1
}

        
    
