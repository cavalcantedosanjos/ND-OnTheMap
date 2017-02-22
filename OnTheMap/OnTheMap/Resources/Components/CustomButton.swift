//
//  CustomButton.swift
//  OnTheMap
//
//  Created by Joao Anjos on 06/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    @IBInspectable
    var masksToBounds: Bool = false {
        didSet {
            self.layer.masksToBounds = self.masksToBounds
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }

    
  

}
