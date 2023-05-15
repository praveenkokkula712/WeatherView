//
//  ViewController.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 11/05/23.
//

import UIKit
import SwiftUI
import CoreLocation
import MapKit

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    var isCurrentLocationFetched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /// Method will launch the US country along with the states on button aciton
    /// - Parameter sender: UIButton
    @IBAction func getUsBasedWeatherReport(_ sender: Any) {
        let viewModel = CountryViewModel(regionType: .unitedStates)
        let countryView = CountryView(viewModel: viewModel)
        let hostingView = UIHostingController(rootView: countryView)
        hostingView.modalPresentationStyle = .fullScreen
        self.present(hostingView, animated: true)
    }
    
    /// Method will launch the all countries around the world
    /// - Parameter sender: UIButton
    @IBAction func countryBasedWeatherReport(_ sender: Any) {
        let viewModel = CountryViewModel()
        let countryView = CountryView(viewModel: viewModel)
        let hostingView = UIHostingController(rootView: countryView)
        hostingView.modalPresentationStyle = .fullScreen
        self.present(hostingView, animated: true)
    }
    
    /// Method will fetch the user current location weather report.
    /// - Parameter sender: UIButton
    @IBAction func fetchCurrentLocationWeatherReport(_ sender: Any) {
        self.getCurrentLocation()
    }
}
