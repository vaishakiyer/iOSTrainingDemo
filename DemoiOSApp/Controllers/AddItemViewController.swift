//
//  AddItemViewController.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 15/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import UIKit

protocol SendData: AnyObject{
    func valuesToBePopulated(object: MyObject)
}

class AddItemViewController: UIViewController {

    @IBOutlet weak var addedImg: UIImageView!
    
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descTxt: UITextView!
    
    weak var delegate: SendData?
    var objCreated =  MyObject(title: "", description: "", image: UIImage(named: "A ship in Balestrand")!)
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTxt.delegate = self
        descTxt.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setup()
        // Do any additional setup after loading the view.
    }
    
    
    func setup(){
        
        
        addedImg.layer.cornerRadius = addedImg.frame.width / 2
        self.navigationItem.title = "Add Items"
        
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissMe))
        
        let rb1 = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(openActionsheet))
        
        let rb2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        self.navigationItem.rightBarButtonItems = [rb2,rb1]
        
    }
    
    @objc func dismissMe(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
   @objc func openActionsheet(){
        let actionVC = UIAlertController(title: "Choose you option", message: "", preferredStyle: .actionSheet)
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        
        let gallery = UIAlertAction(title: "Gallery", style: .default) { (weak) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (weak) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionVC.addAction(gallery)
        actionVC.addAction(camera)
        actionVC.addAction(cancel)
        
        self.present(actionVC, animated: true, completion: nil)
    }

    
    @objc func doneClicked(){
        
        objCreated.title = titleTxt.text!
        objCreated.description = descTxt.text!
        delegate?.valuesToBePopulated(object: objCreated)
        self.dismiss(animated: true, completion: nil)
    
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
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

extension AddItemViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        
        objCreated.image = selectedImage
        addedImg.image = selectedImage
    }
        
        
    }

extension AddItemViewController: UITextFieldDelegate,UITextViewDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView){
        textView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
}
