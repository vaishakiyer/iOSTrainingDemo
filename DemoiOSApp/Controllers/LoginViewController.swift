//
//  LoginViewController.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 15/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var password: DesignableUITextField!
    
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        email.text = "eve.holt@reqres.in"
        setup()
        // Do any additional setup after loading the view.
    }
    
    
    func setup(){
        
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationItem.title = "LOGIN PAGE"
        
        email.delegate = self
        password.delegate = self
        email.addImageAndPlaceHolder(img: "Group 381", placeHolder: "EMAIL ID")
        password.addImageAndPlaceHolder(img: "Group 382", placeHolder: "PASSWORD")
        
        Helper.addLineToView(view: email, position: .LINE_POSITION_BOTTOM, color: .white, width: 0.5)
        Helper.addLineToView(view: password, position: .LINE_POSITION_BOTTOM, color: .white, width: 0.5)
        
        signIn.layer.cornerRadius = 10
        registerBtn.layer.cornerRadius = 10
        
        
        signIn.addTarget(self, action: #selector(signInPress), for: .touchUpInside)
        registerBtn.addTarget(self, action: #selector(registerPress), for: .touchUpInside)
        
    }
    
    
    @objc func registerPress(){
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController")
        let nc = UINavigationController.init(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
        
    }
    
    
    @objc func signInPress(){
        loginPressed(username: email.text!, password: password.text!)
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

extension LoginViewController:UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func loginPressed(username: String,password: String){
        
        Spinner.start(style: .whiteLarge, backColor: .clear, baseColor: .white)
        let parameter = ["email": username, "password": password]
        
        AF.request(URL(string: "https://reqres.in/api/register")!, method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil).responseJSON { (response) in
            
            Spinner.stop()
            
            switch response.result{
                
            case .success(let JSON):
                print(JSON)
                
                
                guard let token = (JSON as? NSDictionary)?.value(forKey: "token") as? String else {
                    
                    let alertVC = UIAlertController(title: "Error Signing in", message: "Please check the credentials", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertVC.addAction(okAction)
                    self.present(alertVC, animated: true, completion: nil)
                    
                    return}
                Userdefault.setToken(token: token)
                
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "HomeTabViewController")
                let nc = UINavigationController.init(rootViewController: vc)
                self.present(nc, animated: true, completion: nil)
                
            case .failure(let error):
                
                let alertVC = UIAlertController(title: "Error Signing in", message: "", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(okAction)
                self.present(alertVC, animated: true, completion: nil)
                print(error)
                
            }
            
            
        }
        
        
    }
    
    
}


enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

class Helper{
    
    class func dropShadowOnTableView(table: UITableView){
        
        table.layer.masksToBounds = false
        table.layer.shadowColor = UIColor.darkGray.cgColor
        table.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        table.layer.shadowOpacity = 0.5
        table.layer.shadowRadius = 6
        
    }
    
    
    class func addLineToView(view : UIView, position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        view.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
    
}

extension UITextField{
    
    func addImageAndPlaceHolder(img: String, placeHolder: String){
        
        
        self.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.groupTableViewBackground])
        self.leftViewMode = UITextField.ViewMode.always
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: img)
        imageView.image = image
        self.leftView = imageView
    }
    
    
    
}
