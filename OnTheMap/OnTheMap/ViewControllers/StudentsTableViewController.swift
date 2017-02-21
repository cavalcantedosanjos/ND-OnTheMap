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
    let kLocationSegue = "locationSegue"
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        locations = (UIApplication.shared.delegate as! AppDelegate).locations
        tableView.reloadData()
    }
    
    
    
    // MARK: - Actions
    @IBAction func logoutButton_Clicked(_ sender: Any) {
        self.present(LoginViewController.newInstanceFromStoryboard(), animated: true, completion: nil)
        
        StudentService.sharedInstance().logout(onSuccess: {
            //Nothing
        }, onFailure: { (error) in
            //Nothing
        }, onCompleted: {
            //Nothing
        })

    }
    
    @IBAction func refreshButton_Clicked(_ sender: Any) {
        getStudentsLocation()
    }
    
    @IBAction func pinButton_Clicked(_ sender: Any) {
        if User.current.location != nil{
            let alert: UIAlertController = UIAlertController(title: "", message: "You Have Already Posted a Student Location. Would You Like to Overwrite. Your Current Location?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Overwrite", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "locationSegue", sender: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        performSegue(withIdentifier: kLocationSegue, sender: nil)
    }
    // MARK: - Services
    func getStudentsLocation() {
        
        LocationService.sharedInstance().getStudentsLocation(onSuccess: { (studentsLocation) in
            
            (UIApplication.shared.delegate as! AppDelegate).locations = []
            if studentsLocation.count > 0 {
                (UIApplication.shared.delegate as! AppDelegate).locations = studentsLocation
                self.locations = studentsLocation
            }
            
        }, onFailure: { (error) in
            
        }, onCompleted: {
            self.tableView.reloadData()
        })
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
