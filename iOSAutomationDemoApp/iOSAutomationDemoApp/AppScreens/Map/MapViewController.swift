//
//  MapViewController.swift
//  iOSAutomationDemoApp
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
  private var locationManager: CLLocationManager!
  private var currentLocation: CLLocation?
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest

    if CLLocationManager.locationServicesEnabled() {
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    defer { currentLocation = locations.last }

    if currentLocation == nil {
      if let userLocation = locations.last {
        let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000, 2000)
        mapView.setRegion(viewRegion, animated: false)
      }
    }
  }
}
