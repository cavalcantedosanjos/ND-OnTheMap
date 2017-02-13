//
//  URLFactory.swift
//  OnTheMap
//
//  Created by Joao Anjos on 13/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

class URLFactory: NSObject {
    
    // MARK: Shared Instance
    class func sharedInstance() -> URLFactory {
        struct Singleton {
            static var sharedInstance = URLFactory()
        }
        return Singleton.sharedInstance
    }

    
    func autentitionUrl() -> String {
        return Environment.sharedInstance().baseUdacityUrl + "/api/session"
    }
}
