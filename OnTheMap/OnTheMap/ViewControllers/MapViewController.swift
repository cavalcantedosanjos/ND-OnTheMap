//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Joao Anjos on 06/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var studentsMapView: MKMapView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StudentService.sharedInstance().getStudentsLocation(onSuccess: { (studentsLocation) in
            
            self.addAnnotations(locations: studentsLocation)
            (UIApplication.shared.delegate as! AppDelegate).locations = []
            (UIApplication.shared.delegate as! AppDelegate).locations = studentsLocation
            
        }, onFailure: {
            
        }, onCompleted: {
            
        })
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    func addAnnotations(locations: [StudentLocation]) {
        var annotations: [MKAnnotation] = [MKAnnotation]()
        
        for location in locations {
            
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = location.fullName()
            annotation.subtitle = location.mediaUrl!
            
            annotations.append(annotation)
        }
        
        self.studentsMapView.showAnnotations(annotations, animated: true)
    }
    
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
                if let url = URL(string: toOpen) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    
                }
            }
        }
    }
}
