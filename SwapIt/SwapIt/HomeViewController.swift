//
//  HomeViewController.swift
//  SwapIt
//
//  Created by Yao Yu on 4/30/20.
//  Copyright © 2020 FONZIES_LAB. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currency:[String] = []
    var values: [String] = []
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=950d9516c67b78c187ebee7055841efc")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("error")
            }
            else {
                if let content = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(myJson)
                        if let rates = myJson["rates"] as? NSDictionary {
                            for (key, value) in rates {
                                self.currency.append((key as? String)!)
                                self.values.append((value as? Double)!)
                            }
                            print(self.currency)
                            print(self.values)
                        }
                    }
                    catch {
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currencies = currency[indexPath.row]
        let value = values[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
        cell.currencyLabel.text = currencies
        cell.valuesLabel.text = value
        return cell
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
