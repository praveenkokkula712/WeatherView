//
//  CountryViewModel.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 11/05/23.
//

import Foundation

@MainActor
class CountryViewModel: ObservableObject {
    
    @Published var countries: CountriesModel?
    var regionType: RegionType = .row
    
    init(regionType : RegionType = .row) {
        self.regionType = regionType
    }
    
    func fetchCountries() async throws {
        let serviceLayer = ServiceLayer.shared
        let url = "https://countriesnow.space/api/v0.1/countries"
        let data = try await serviceLayer.getResponse(from: url)
        self.countries = try? data.jsonDecoder(CountriesModel.self).get()
    }
    
    func countriesData(from searchCountry: String) -> [CountryModel]? {
        switch self.regionType {
        case .unitedStates:
            let countriesData = self.countries?.countriesData?.filter({$0.country?.contains(self.regionType.rawValue) ?? true})
            if searchCountry.isEmpty {
                return countriesData
            }
            let reponse =  self.countries?.countriesData?.filter({$0.country?.contains(searchCountry) ?? true})
            return reponse
        case .row:
            if searchCountry.isEmpty {
                return self.countries?.countriesData
            }
            let reponse =  self.countries?.countriesData?.filter({$0.country?.contains(searchCountry) ?? true})
            return reponse
        }
    }
}
