//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 11/05/23.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var weatherViewModel: WeatherViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                if let weather = weatherReport.0 {
                    Text(weatherReport.1 ?? "")
                        .font(.largeTitle)
                    Text(weather.main)
                        .font(.largeTitle)
                    Text(weather.description)
                        .font(.title)
                    AsyncImage(url: URL(string: ServiceLayer.imageUrl + "/\(weather.icon)@2x.png"))
                        .frame(width: 80, height: 80, alignment: .center)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Weather Report")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
        .onAppear {
            Task {
                try await self.weatherViewModel.fetchWeatherReport()
            }
        }
    }
    
    var weatherReport: (Weather?, String?) {
        (self.weatherViewModel.weatherReport?.weather?.first, self.weatherViewModel.weatherReport?.name)
    }
}

