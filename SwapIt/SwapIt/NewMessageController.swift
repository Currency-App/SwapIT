//
//  NewMessageController.swift
//  SwapIt
//
//  Created by Alfonso Garibay on 5/3/20.
//  Copyright © 2020 FONZIES_LAB. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {

    let cellId = "cellId"
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.registerClass(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
    }

    func fetchUser() {
        
        FIRDatabase.database().reference().child("users").observeEventType(.ChildAdded, withBlock: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user = User()
                user.setValueForKeysWithDictionary(dictionary)
                self.users.append(user)
                
                
                dispatch_async(dispatch_get_main_queue(), {
                  self.tableView.reloadData()
                })
                
               // user.name = dictionary["firstName"]
               // user.email = dictionary["email"]
                
                print(user.name, user.email)
            }
            
            //print("User found")
            //print(snapshot)
            
        },withCancelBlock: nil)
    }
    
    func handleCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count // <-- number of rows to display(users)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        
        let user = users[indexPath.row]
        // there should be any number of rows with the following info (username and email)
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
    
}

class UserCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
