//
//  ServiceManager.swift
//  OnTheMap
//
//  Created by Joao Anjos on 08/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

class ServiceManager: NSObject {

    enum HttpMethod: String {
        case GET = "GET"
        case POST = "POST"
        case DELETE = "DELETE"
        case PUT = "PUT"
    }
    
    func request(method: HttpMethod, url: String, parameters: [String:AnyObject], headers: [String: String],
                 onSuccess: () -> Void,
                 onFailure: () -> Void,
                 onCompleted: ()-> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: url)!)
        
        for header in headers {
             request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            if error != nil { // Handle error
                return
            }
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        
        
        
        }
        
        task.resume()
    }
    
}
