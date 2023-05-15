//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 15/05/23.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    
    @Published var weatherReport: WeatherResponse?
    var city: String
    
    init(weatherReport: WeatherResponse? = nil, city: String) {
        self.weatherReport = weatherReport
        self.city = city
    }
    
    func fetchWeatherReport() async throws {
        let service = ServiceLayer.shared
        let response = try await service.getResponse(from: ServiceLayer.baseUrl, with: queryItems)
        self.weatherReport = try? response.jsonDecoder(WeatherResponse.self).get()
    }
    
    private var queryItems: [URLQueryItem] {
        let cityItem = URLQueryItem(name: "q", value: city)
        let apiKeyItem = URLQueryItem(name: "appid", value: ServiceLayer.apiKey)
        var queryItems = [URLQueryItem]()
        queryItems.append(cityItem)
        queryItems.append(apiKeyItem)
        return queryItems
    }
    
}
