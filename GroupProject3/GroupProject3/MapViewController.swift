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
    var list = [Object]()
    var lat: Double?
    var lon: Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkLocationServiceEnabled()
        getAPI()
        //print(lat)
        //print(lon)
        
        
    }
    private func addAnnotation(api: [Object]? = nil) {
        guard let locations = api else {return}
        for loc in locations{
            let lat = Double(loc.latitude)!
            let lng = Double(loc.longtitude)!
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: lat)!, longitude: CLLocationDegrees(exactly: lng)!)
            annotation.title = loc.nameGe
            self.mapView.addAnnotation(annotation)
        }
    }
    
    
    
    func getAPI(){
      APIServices.decode(){ (res) in
          let list = res.objects
          for object in list {
            self.list.append(object)
              
          }
        DispatchQueue.main.async {
            self.addAnnotation(api: self.list)
        }
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
    
    private func centerMapView() {
        let mapMeterds: Double = 5_000
        guard let location = locationManager.location else {return}
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: mapMeterds, longitudinalMeters: mapMeterds)
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        centerMapView()
        manager.stopUpdatingLocation()
    }
}
