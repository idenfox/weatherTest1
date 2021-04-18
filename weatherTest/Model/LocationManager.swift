//
//  LocationViewModel.swift
//  weatherTest
//
//  Created by Renzo Paul Chamorro on 17/04/21.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject ,CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    @Published var location = LocationModel(latitude: 0, Longitude: 0)

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        location.latitude = lastKnownLocation!.latitude
        location.Longitude = lastKnownLocation!.longitude
    }
}
