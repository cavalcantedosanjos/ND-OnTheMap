//
//  Environment.swift
//  OnTheMap
//
//  Created by Joao Anjos on 13/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

class Environment: NSObject {
    
    // MARK: Shared Instance
    class func sharedInstance() -> Environment {
        struct Singleton {
            static var sharedInstance = Environment()
        }
        return Singleton.sharedInstance
    }
    
    let parseApplicationId: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    let parseRestApiKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    let baseUdacityUrl: String = "https://www.udacity.com"
    let baseParseUrl: String = "https://parse.udacity.com"
}
