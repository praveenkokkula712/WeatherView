//
//  ViewController+CLLocationManager.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 15/05/23.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

extension ViewController: CLLocationManagerDelegate {
    
    func getCurrentLocation() {
        self.isCurrentLocationFetched = true
        let manager = CLLocationManager()
        switch manager.authorizationStatus {
        case .restricted, .denied:
            self.showAlert()
        default:
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            DispatchQueue.global().async {
                if CLLocationManager.locationServicesEnabled() {
                    self.locationManager.delegate = self
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    self.locationManager.startUpdatingLocation()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        location.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
            print(placemark.locality ?? "")
            self.locationManager.stopUpdatingLocation()
            if self.isCurrentLocationFetched {
                Task {
                    await self.getWeatherFromCity(cityName: placemark.locality ?? "")
                }
            }
        }
    }
    
    func getWeatherFromCity(cityName:String) async {
        let weatherViewModel = WeatherViewModel(city: cityName)
        self.launchWeatherView(viewModel: weatherViewModel)
    }
    
    private func launchWeatherView(viewModel: WeatherViewModel) {
        if self.isCurrentLocationFetched {
            self.isCurrentLocationFetched = false
            let hostingView = UIHostingController(rootView: WeatherView(weatherViewModel: viewModel))
            hostingView.modalPresentationStyle = .fullScreen
            let topViewController = UIApplication.topViewController()
            topViewController?.present(hostingView, animated: false)
        }
    }
    
    func showAlert() {
        let dialogMessage = UIAlertController(title: nil, message: "Can't access Loction", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}

