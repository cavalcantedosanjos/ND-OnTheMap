//
//  ShowLocationViewController.swift
//  OnTheMap
//
//  Created by Joao Anjos on 14/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit
import MapKit

class ShowLocationViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var studentsMapView: MKMapView!
    
    // MARK: - Actions
    @IBAction func cancelButton_Clicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }



}

// MARK: - MKMapViewDelegate

extension ShowLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseIdentifier = "pin"
        
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if pin == nil {
            pin = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pin!.canShowCallout = true
        }
        else {
            pin!.annotation = annotation
        }
        
        pin!.image = UIImage(named: "ic_pin")
        
        
        return pin
    }
}
