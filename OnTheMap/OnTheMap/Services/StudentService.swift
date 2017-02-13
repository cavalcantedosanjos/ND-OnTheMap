//
//  StudentService.swift
//  OnTheMap
//
//  Created by Joao Anjos on 13/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

class StudentService: NSObject {
    
    // MARK: Shared Instance
    class func sharedInstance() -> StudentService {
        struct Singleton {
            static var sharedInstance = StudentService()
        }
        return Singleton.sharedInstance
    }
    
    func autentication(username: String, password: String,
                       onSuccess: @escaping () -> Void,
                       onFailure: @escaping () -> Void,
                       onCompleted: @escaping ()-> Void) {
        
        
        let parameters = [
            "udacity": [
                "username": username,
                "password": password
            ]
        ]
        
        ServiceManager.sharedInstance().request(method: .POST, url: URLFactory.sharedInstance().autentitionUrl(), parameters: parameters as [String : AnyObject]?, onSuccess: { (res) in
            print(res)
        }, onFailure: {
            
        }, onCompleted: {
        
        })
        
    }
    
    
}
