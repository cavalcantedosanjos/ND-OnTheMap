//
//  StudentsTableViewController.swift
//  OnTheMap
//
//  Created by Joao Anjos on 06/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var locations: [StudentLocation] = [StudentLocation]()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        locations = (UIApplication.shared.delegate as! AppDelegate).locations
        tableView.reloadData()
    }
    
    // MARK: - UITableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell") as! StudentsTableViewCell
        cell.setup(location: locations[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let url = URL(string: locations[indexPath.row].mediaUrl!) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            
        }
    }
    
}
