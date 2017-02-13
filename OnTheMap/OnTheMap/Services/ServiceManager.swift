//
//  ServiceManager.swift
//  OnTheMap
//
//  Created by Joao Anjos on 08/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

class ServiceManager: NSObject {

    // MARK: Shared Instance
    class func sharedInstance() -> ServiceManager {
        struct Singleton {
            static var sharedInstance = ServiceManager()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: HttpMethods
    enum HttpMethod: String {
        case GET = "GET"
        case POST = "POST"
        case DELETE = "DELETE"
        case PUT = "PUT"
    }
    
    func request(method: HttpMethod, url: String, parameters: AnyObject? = nil, headers: [String: String]? = nil,
                 onSuccess: @escaping (_ dictionary: AnyObject) -> Void,
                 onFailure: @escaping () -> Void,
                 onCompleted: @escaping ()-> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod	= method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")

        if let headers = headers{
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch {
                //TODO
            }
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
          
            guard (error == nil) else {
                //TODO
                onFailure()
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
               //
                return
            }
            
            do {
                let newData = data?.subdata(in: Range(uncheckedBounds: (5, data!.count)))
                let parsedResult = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as AnyObject
                onSuccess(parsedResult)
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
                print(userInfo)
            }

            onCompleted()

        }
        
        task.resume()
    }
    
}
