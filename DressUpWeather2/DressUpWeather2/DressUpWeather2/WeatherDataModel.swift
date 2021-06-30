//
//  WeatherDataModel.swift
//  DressUpWeather2
//
//  Created by Kacper on 30/06/2021.
//

import Foundation

struct WeatherDataModel: Codable {
    var weather: [Weather]
    var main: Temperature
}

struct Weather: Codable {
    var main: String
    var description: String
}

struct Temperature: Codable {
    var temp: Double
}
