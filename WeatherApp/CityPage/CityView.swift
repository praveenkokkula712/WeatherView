//
//  CityView.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 11/05/23.
//

import SwiftUI

struct CityView: View {
    
    @ObservedObject var cityViewModel: CityViewModel
    @State var isPresented: Bool = false
    @State var searchCity: String = ""
    @Environment(\.dismiss) var dismiss
    @State var cityName = ""
    
    var body: some View {
        let cities = cityViewModel.getFilteredCities(from: self.searchCity)
        if !cities.isEmpty {
            List(cityViewModel.getFilteredCities(from: self.searchCity), id: \.self) { cityName in
                Text(cityName)
                    .onTapGesture {
                        Task {
                            DispatchQueue.main.async {
                                self.cityName = cityName
                            }
                            self.isPresented = true
                        }
                    }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Return to sender") {
                        dismiss()
                    }
                }
            }
            .searchable(text: $searchCity)
            .fullScreenCover(isPresented: $isPresented, content: {
                WeatherView(weatherViewModel: WeatherViewModel(city: self.cityName))
            })
        } else {
            ProgressView()
        }
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(cityViewModel: CityViewModel(citiesList: [""]))
    }
}
