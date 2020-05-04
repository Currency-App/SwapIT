//
//  MessagesViewController.swift
//  SwapIt
//
//  Created by Nanar Boursalian on 5/1/20.
//  Copyright © 2020 FONZIES_LAB. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    // My text Field
           @IBOutlet weak var textField: UITextField
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
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
        
}

        
    
/*
     // Start of parse chat lab example code*******
            // Use the class name: Message (this is case sensitive).
            let chatMessage = PFObject(className: "Message")
            
            // Store the text of the text field in a key called text. (Provide a default empty string so message text is never nil)
            chatMessage["text"] = chatMessageField.text ?? ""
           
            // Call saveInBackground(block:) and print when the message successfully saves or any errors.
            chatMessage.saveInBackground { (success, error) in
               if success {
                  print("The message was saved!")
               } else if let error = error {
                  print("Problem saving message: \(error.localizedDescription)")
               }
            }
            // fin, parse chat lab example code..... *******
     */
    

