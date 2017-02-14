//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Joao Anjos on 06/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

struct StudentInformation {
    
    static let currentUser = StudentInformation();
    
    var key: String?
    var registered: Bool?
    var expiration: String?
    var sessionId: String?
    var location:StudentLocation?
   
    init() {
        
    }
    
    
    
}
