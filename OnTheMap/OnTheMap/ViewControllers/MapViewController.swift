//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Joao Anjos on 06/02/17.
//  Copyright © 2017 Joao Anjos. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var studentsMapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 2000
    var locationManager: CLLocationManager = CLLocationManager()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthorizationStatus()
        
        StudentService.sharedInstance().getStudentsLocation(onSuccess: { (res) in
            
        }, onFailure: { 
            
        }, onCompleted: {
        
        })
    }
    
    // MARK: - Actions
    
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            studentsMapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            self.locationManager.stopUpdatingLocation()
            zoomToUserCoordinate(userLocation: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationManager.stopUpdatingLocation()
    }

}


// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func zoomToUserCoordinate(userLocation: CLLocation) {
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let location = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.latitude)
        let region = MKCoordinateRegionMake(location, span)
        self.studentsMapView.setRegion(region, animated: true)
    }
    
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
