//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Joao Anjos on 06/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Storyboard Restoration
    class func newInstanceFromStoryboard() -> LoginViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        return vc
    }

    
    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: CustomButton!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        enableActivityIndicator(enable: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - Actions
    @IBAction func loginButton_clicked(_ sender: Any) {
        
        guard let username = emailTextField.text, !username.isEmpty  else {
            showMessage(message: "Required E-mail.", title: "Invalid Field!")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showMessage(message: "Required Password.", title: "Invalid Field!")
            return
        }
        
        
       enableActivityIndicator(enable: true)
        self.view.endEditing(true)
        StudentService.sharedInstance().autentication(username: username, password: password, onSuccess: { (info) in
            
            StudentInformation.currentUser = info
            self.performSegue(withIdentifier: "tabBarSegue", sender: nil)
            
        }, onFailure: { (error) in
            self.showMessage(message: error.error!, title: "")
        }, onCompleted: {
            self.enableActivityIndicator(enable: false)
        })
    }
    
    @IBAction func singUpButton_clicked(_ sender: Any) {
         UIApplication.shared.open(URL(string: "https://www.udacity.com/account/auth#!/signup")!, options: [:], completionHandler: nil)
    }
    
    // MARK: - Helpers
    func showMessage(message: String, title: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func enableActivityIndicator(enable: Bool){
        if enable {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        loginButton.isUserInteractionEnabled = !enable
        activityIndicator.isHidden = !enable
    }
    
    // MARK: - Keyboard
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        let heightKeyboard =  keyboardSize.cgRectValue.height - 60
        
        self.view.frame.origin.y = heightKeyboard  * (-1)
    }
    
    func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }
}
