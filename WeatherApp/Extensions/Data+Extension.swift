//
//  Data+Extension.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 11/05/23.
//

import Foundation

extension Data {
    
    func jsonDecoder<T>(_ type: T.Type) -> Result<T, Error> where T:Decodable {
        do {
            let item = try JSONDecoder().decode(type, from: self)
            return .success(item)
        }
        catch {
            return .failure(error)
        }
    }
    
}
