//
//  MapViewController.swift
//  GroupProject3
//
//  Created by Kato on 6/19/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

  let locationManager = CLLocationManager()
  @IBOutlet var mapView: MKMapView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    checkAuthorizationStatus()
    //addAnnotation(api: list)
  }
  private func addAnnotation(api: List? = nil) {
    guard let locations = api else {return}
    for loc in locations.objects{
      let lat = Double(loc.latitude)!
      let lng = Double(loc.longtitude)!
      let annotation = MKPointAnnotation()
      annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: lat)!, longitude: CLLocationDegrees(exactly: lng)!)
      annotation.title = loc.nameGe
      self.mapView.addAnnotation(annotation)
    }
  }
  private func checkLocationServiceEnabled() {
    if CLLocationManager.locationServicesEnabled() {
      setupLocationManager()
      checkAuthorizationStatus()
    } else {
    }
  }
  private func setupLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  private func checkAuthorizationStatus() {
    switch CLLocationManager.authorizationStatus() {
    case .authorizedWhenInUse:
      locationManager.startUpdatingLocation()
      mapView.showsUserLocation = true
    case .authorizedAlways:
      break
    case .denied:
      break
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted:
      break
    @unknown default:
      fatalError()
    }
  }
}

extension MapViewController: CLLocationManagerDelegate{
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    manager.stopUpdatingLocation()
  }
}
