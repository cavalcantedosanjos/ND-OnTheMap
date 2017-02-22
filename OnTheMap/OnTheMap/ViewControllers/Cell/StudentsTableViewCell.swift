//
//  StudentsTableViewCell.swift
//  OnTheMap
//
//  Created by Joao Anjos on 06/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

class StudentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mediaUrl: UILabel!
    
    func setup(location: StudentLocation) {
        name.text = location.fullName()
        mediaUrl.text = location.mediaUrl!
    }
}
