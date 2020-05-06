//
//  ChatViewController.swift
//  SwapIt
//
//  Created by Yao Yu on 5/5/20.
//  Copyright © 2020 FONZIES_LAB. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendAction(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let toID = user?.id!
        let fromID = Auth.auth().currentUser?.uid
        let values = ["text": messageTextField.text!, "toID": toID, "fromID": fromID]
        childRef.updateChildValues(values)
    
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
