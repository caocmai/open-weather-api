//
//  Weather.swift
//  openWeatherAPI
//
//  Created by Cao Mai on 6/3/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import Foundation

public struct WeatherData: Decodable {
    let name: String?
    let main: Main?
    let weather: [Weather]
}

public struct Main: Decodable {
    let temp: Double?
}

public struct Weather: Decodable {
    let description: String?
    let id: Int?
}
