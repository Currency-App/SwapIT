//
//  MessagesViewController.swift
//  SwapIt
//
//  Created by Yao Yu on 5/4/20.
//  Copyright © 2020 FONZIES_LAB. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newMessagesAction(_ sender: Any) {
        self.performSegue(withIdentifier: "newMessage", sender: nil)
    }

    func getUser(user: User) {
        let chatViewController = ChatViewController()
        chatViewController.user = user
        
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
