//
//  CountryModel.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 11/05/23.
//

import Foundation


struct CountriesModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var error: Bool?
    var message: String?
    var countriesData: [CountryModel]?
    var uuid = UUID()
    
    enum CodingKeys: String, CodingKey {
        case error
        case message = "msg"
        case countriesData = "data"
    }
}

struct CountryModel : Codable, Hashable, Identifiable {
    var country: String?
    var cities: [String] = [String]()
    let id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case country, cities
    }
}
