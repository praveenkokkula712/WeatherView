//
//  ServiceLayer.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 11/05/23.
//

import Foundation


@MainActor
class ServiceLayer {
    
    static let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    static let apiKey = "862e290b89e6a4b247d0469415255466"
    
    static let imageUrl = "https://openweathermap.org/img/wn/"
    
    // shared instance
    static let shared = ServiceLayer()
    
    // Protected level of initializer
    private init() {
        
    }
    
    func getResponse(from url: String, with queryItems: [URLQueryItem]? = nil) async throws -> Data {
        var components = URLComponents(string: url)
        if let queryItems {
            components?.queryItems = queryItems
        }
        if let url = components?.url {
            do  {
                let (data, response) = try await URLSession.shared.data(from: url)
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    return data
                } else {
                    throw NetworkError.statusCodeError
                }
            } catch {
                throw NetworkError.dataParsingError
            }
        } else {
            throw NetworkError.urlNotFound
        }
    }
}
