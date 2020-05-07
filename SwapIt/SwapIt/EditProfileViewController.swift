//
//  EditProfileViewController.swift
//  SwapIt
//
//  Created by Grace Leung on 5/3/20.
//  Copyright © 2020 FONZIES_LAB. All rights reserved.
//

import UIKit
import AlamofireImage
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth


class EditProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var currentText: UITextField!
    @IBOutlet weak var desiredText: UITextField!
    var selectedCurrency: String?
    var currencyType = ["USD", "EUR"]
    var iURL: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        dismissPickerView()
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyType[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currencyType[row]
        currentText.text = selectedCurrency
        desiredText.text = selectedCurrency
        
    }
    func createPickerView()
    {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        currentText.inputView = pickerView
        desiredText.inputView = pickerView
    }
    func dismissPickerView()
    {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        currentText.inputAccessoryView = toolBar
        desiredText.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    
    @IBAction func changePhoto(_ sender: Any) {
        let picker  = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 250, height: 250)
        let scaledImage = image.af_imageAspectScaled(toFill: size )
        
        profileImage.image = scaledImage
        dismiss(animated: true, completion: nil)
        
        var data = Data()
        data = profileImage.image!.jpegData(compressionQuality: 0.8)!
        
        let imageRef = Storage.storage().reference().child("images/" + randomString(length: 20))
        let uploadTask = imageRef.putData(data, metadata: nil) {(metadata, error) in
            guard let metadata = metadata else {return}
            let size = metadata.size
            imageRef.downloadURL{ (url, error) in
                guard let downloadURL = url else {return}
                self.iURL = url?.absoluteString
                print(self.iURL! as String)
            }
        }
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    @IBAction func saveProfile(_ sender: Any) {
        
        guard let userProfile = UserService.currentUserProfile else {return}
        
        guard let profilename = nameText.text, !profilename.isEmpty else {return}
        guard let desiredC = desiredText.text, !desiredC.isEmpty else {return}
        guard let currentC = currentText.text, !currentC.isEmpty else {return}
        guard let profileImage = iURL, !profileImage.isEmpty else {return}
        
        let profileRef = Database.database().reference().child("profile").childByAutoId()
        let profileObject = [
            "author": [
                "userID": userProfile.id
            ],
            "profilename": profilename,
            "desiredCurrency": desiredC,
            "currentCurrency": currentC,
            "profileImage": profileImage
        ] as [String: Any]
        
        if Auth.auth().currentUser?.uid != nil
        {
            profileRef.updateChildValues(profileObject)
        }
        else
        {
            profileRef.setValue(profileObject)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
