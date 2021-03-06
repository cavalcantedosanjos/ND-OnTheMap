//
//  URLFactory.swift
//  OnTheMap
//
//  Created by Joao Anjos on 13/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

class URLFactory: NSObject {
    
    
    class func autentitionUrl() -> String {
        return Environment.sharedInstance().baseUdacityUrl + "/api/session"
    }
    
    class func userInformationUrl(key: String) -> String {
        return Environment.sharedInstance().baseUdacityUrl + "/api/users/\(key)"
    }
    
    class func studentsLocationUrl() -> String {
        return Environment.sharedInstance().baseParseUrl + "/parse/classes/StudentLocation"
    }
    
    
}
