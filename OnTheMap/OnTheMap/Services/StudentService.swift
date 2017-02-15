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
        
        ServiceManager.sharedInstance().request(method: .POST, url: URLFactory.autentitionUrl(),
                                                parameters: parameters as AnyObject?, onSuccess: { (data) in
            
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count)))
            let parsedResult = JSON.deserialize(data: newData)
            
            let student = StudentInformation(dictionary: parsedResult as! [String : AnyObject])
            onSuccess(student)
            
        }, onFailure: {
            
        }, onCompleted: {
            onCompleted()
        })
        
    }
    
    func getStudentsLocation(onSuccess: @escaping (_ locations: [StudentLocation]) -> Void,
                             onFailure: @escaping () -> Void,
                             onCompleted: @escaping ()-> Void) {
        
        ServiceManager.sharedInstance().request(method: .GET, url: URLFactory.getStudentsLocationUrl(),  onSuccess: { (data) in
            
            let parsedResult = JSON.deserialize(data: data)
            if let results = parsedResult["results"] as? [[String:AnyObject]] {
                var locations: [StudentLocation] = [StudentLocation]()
                
                for result in results {
                    locations.append(StudentLocation(dictionay: result))
                }
                onSuccess(locations)
            }
            
        }, onFailure: {
            
        }, onCompleted: {
            onCompleted()
        })
    }
    
    
}
