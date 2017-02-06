//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Joao Anjos on 06/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    // MARK: - Actions
    @IBAction func loginButton_clicked(_ sender: Any) {
        
    }
    
    @IBAction func singUpButton_clicked(_ sender: Any) {
        
    }
    
    @IBAction func facebookButton_clicked(_ sender: Any) {
        
    }
    
    // MARK: - Helpers
    
    
}
