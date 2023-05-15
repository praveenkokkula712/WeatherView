//
//  CityView.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 11/05/23.
//

import SwiftUI

struct CountryView: View {
    
    @ObservedObject var viewModel: CountryViewModel
    @State var searchCountry: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            if self.viewModel.countries?.countriesData?.isEmpty ?? false{
                ProgressView()
            } else {
                if let countries = viewModel.countriesData(from: self.searchCountry) {
                    List(countries) { country in
                        NavigationLink(country.country ?? "") {
                            CityView(cityViewModel: CityViewModel(citiesList: country.cities))
                        }
                    }
                    .navigationTitle("Countries")
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Return to sender") {
                                dismiss()
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .searchable(text: $searchCountry)
        .autocorrectionDisabled()
        .onAppear(perform: {
            Task {
                try await viewModel.fetchCountries()
            }
        })
        .edgesIgnoringSafeArea(.all)
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(viewModel: CountryViewModel())
    }
}
