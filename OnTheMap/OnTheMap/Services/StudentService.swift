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
                       onSuccess: @escaping (_ student: StudentInformation) -> Void,
                       onFailure: @escaping () -> Void,
                       onCompleted: @escaping ()-> Void) {

        let parameters = [
            "udacity": [
                "username": username,
                "password": password
            ]
        ]
        
        ServiceManager.sharedInstance().request(method: .POST, url: URLFactory.autentitionUrl(), parameters: parameters as AnyObject?, onSuccess: { (data) in
        
            let s = StudentInformation()
            do {
                let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count)))
                let parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments)
                print(parsedResult)
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
                print(userInfo)
            }
            
            onSuccess(s)
            
        }, onFailure: {
            
        }, onCompleted: {
            onCompleted()
        })
        
    }
    
    func getStudentsLocation(onSuccess: @escaping () -> Void,
                            onFailure: @escaping () -> Void,
                            onCompleted: @escaping ()-> Void) {
        
        ServiceManager.sharedInstance().request(method: .GET, url: URLFactory.getStudentsLocationUrl(),  onSuccess: { (data) in
            
            var parsedResult: AnyObject?
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
                print(parsedResult ?? "")
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
                print(userInfo)
            }
            
            let response = parsedResult as! [String: AnyObject]
            
            let r = response["result"] ?? nil
            
            
            

            
        }, onFailure: {
            
        }, onCompleted: {
            onCompleted()
        })
    }
    
}
