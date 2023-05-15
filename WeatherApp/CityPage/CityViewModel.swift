//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 15/05/23.
//

import Foundation

class CityViewModel: ObservableObject {
    @Published var citiesList: [String]
    
    init(citiesList: [String]) {
        self.citiesList = citiesList
    }
    
    func getFilteredCities(from text: String) -> [String] {
        if text.isEmpty {
            return citiesList
        }
        return citiesList.filter({$0.contains(text)})
    }
}
