//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Praveen Kokkula on 11/05/23.
//

import Foundation

enum NetworkError: Error {
    case urlNotFound
    case dataParsingError
    case statusCodeError
}
