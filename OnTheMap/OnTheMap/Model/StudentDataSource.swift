//
//  StudentDataSource.swift
//  OnTheMap
//
//  Created by Joao Anjos on 23/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

struct StudentDataSource {
    var studentData = [StudentLocation]()
    static var sharedInstance = StudentDataSource()
}
