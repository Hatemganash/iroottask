//
//  MapVC.swift
//  rootsTask
//
//  Created by Hatem on 21/04/2025.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: BaseVC ,CLLocationManagerDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Properties
    private let locationManager = CLLocationManager()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        checkLocationAuthorization()
    }

    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            showAlertToEnableLocation()
        @unknown default:
            break
        }
    }

    private func showAlertToEnableLocation() {
        let alert = UIAlertController(title: "Location Permission Denied",
                                      message: "Please enable location access in Settings to use the map.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let loc = locations.first else { return }
           let region = MKCoordinateRegion(center: loc.coordinate,
                                           latitudinalMeters: 700,
                                           longitudinalMeters: 700)
           mapView.setRegion(region, animated: true)

           
           let annotation = MKPointAnnotation()
           annotation.coordinate = loc.coordinate
           mapView.addAnnotation(annotation)

           locationManager.stopUpdatingLocation()
       }
}
