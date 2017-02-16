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
                       onFailure: @escaping (_ error: ErrorResponse) -> Void,
                       onCompleted: @escaping ()-> Void) {
        
        let parameters = [
            "udacity": [
                "username": username,
                "password": password
            ]
        ]
        
        ServiceManager.sharedInstance().request(method: .POST, url: URLFactory.autentitionUrl(), parameters: parameters as AnyObject?, onSuccess: { (data) in
            
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count)))
            let parsedResult = JSON.deserialize(data: newData)
            
            let student = StudentInformation(dictionary: parsedResult as! [String : AnyObject])
            onSuccess(student)
            
        }, onFailure: { (error) in
            onFailure(error)
        }, onCompleted: {
            onCompleted()
        })
        
        
        
    }
    
    func logout(onSuccess: @escaping () -> Void,
                onFailure: @escaping (_ error: ErrorResponse) -> Void,
                onCompleted: @escaping ()-> Void){
        
        var xsrfCookie: HTTPCookie? = nil
        
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        
        var header: [String : String] = [:]
        if let xsrfCookie = xsrfCookie {
            header = ["X-XSRF-TOKEN" : xsrfCookie.value ]
        }
        
        
        ServiceManager.sharedInstance().request(method: .DELETE, url: URLFactory.autentitionUrl(), parameters: nil, headers: header, onSuccess: { (data) in
            
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count)))
            print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue)!)
            onSuccess()
        }, onFailure: { (error) in
            onFailure(error)
        }, onCompleted: {
            onCompleted()
        })
        
    }
    
    func getStudentsLocation(_ limit: Int? = 100, _ order: String? = "updatedAt", onSuccess: @escaping (_ locations: [StudentLocation]) -> Void,
                             onFailure: @escaping (_ error: ErrorResponse) -> Void,
                             onCompleted: @escaping ()-> Void) {
        
        
        let url = URLFactory.getStudentsLocationUrl() + "?limit=\(limit)&order=-\(order)"
        
        ServiceManager.sharedInstance().request(method: .GET, url: url,  onSuccess: { (data) in
            
            let parsedResult = JSON.deserialize(data: data)
            if let results = parsedResult["results"] as? [[String:AnyObject]] {
                var locations: [StudentLocation] = [StudentLocation]()
                
                for result in results {
                    locations.append(StudentLocation(dictionay: result))
                }
                onSuccess(locations)
            }
            
        }, onFailure: { (error) in
            onFailure(error)
        }, onCompleted: {
            onCompleted()
        })
    }
    
    func getCurrentLocation(onSuccess: @escaping (_ locations: [StudentLocation]) -> Void,
                            onFailure: @escaping (_ error: ErrorResponse) -> Void,
                            onCompleted: @escaping ()-> Void) {
        
        let url = URLFactory.getStudentsLocationUrl() + "?where={\"uniqueKey\":\"\(StudentInformation.currentUser.key!)\"}"
        
        ServiceManager.sharedInstance().request(method: .POST, url: url, onSuccess: { (data) in
            
            let parsedResult = JSON.deserialize(data: data)
            if let results = parsedResult["results"] as? [[String:AnyObject]] {
                var locations: [StudentLocation] = [StudentLocation]()
                
                for result in results {
                    locations.append(StudentLocation(dictionay: result))
                }
                
                onSuccess(locations)
            }
            
        }, onFailure: { (error) in
            onFailure(error)
        }, onCompleted: {
            onCompleted()
        })
        
    }
    
}
