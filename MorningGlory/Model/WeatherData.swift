//
//  WeatherData.swift
//  MorningGlory
//
//  Created by Shashwat Panda on 08/11/22.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
