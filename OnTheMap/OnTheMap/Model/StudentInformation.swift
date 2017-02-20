//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Joao Anjos on 06/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

struct StudentInformation {
    
    static var currentUser = StudentInformation()
    
    var key: String?
    var registered: Bool?
    var expiration: String?
    var sessionId: String?
    var location:StudentLocation?
   
    init() {
        
    }
    
    init(dictionary: [String : AnyObject]) {
        if let account = dictionary["account"] {
            self.registered = account["registered"] as? Bool ?? false
                        self.key = account["key"] as? String ?? ""
        }
        
        if let session = dictionary["session"] {
            self.sessionId = session["sessionId"] as? String ?? ""
            self.expiration = session["expiration"] as? String ?? ""
        }
    }
}
