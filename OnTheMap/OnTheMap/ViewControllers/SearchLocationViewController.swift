//
//  SearchLocationViewController.swift
//  OnTheMap
//
//  Created by Joao Anjos on 14/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit
import CoreLocation

class SearchLocationViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var findButton: CustomButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        findButton.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    
    // MARK: - Actions
    @IBAction func cancelButton_Clicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func findButton_Clicked(_ sender: Any) {
        
        guard let location = locationTextField.text, !location.isEmpty else {
            
            return
        }
        
        enableActivityIndicator(enable: true)
        let geocoder = git ()
        
        geocoder.geocodeAddressString(locationTextField.text!) { (places, error) in
            
            self.enableActivityIndicator(enable: false)
            
            guard (error == nil) else {
                //TODO
                
                return
            }
            
            if let place = places?.first {
                
            }

        }
    
        performSegue(withIdentifier: "showLocationSegue", sender: nil)
    }

    // MARK: - Helpers
    func enableActivityIndicator(enable: Bool){
        if enable {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }

        activityIndicator.isHidden = !enable
    }
    
    func showMessage(message: String, title: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
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
extension SearchLocationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Enter Your Location Here" {
            textField.text = ""
            findButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
