//
//  Weather.swift
//  WindyWeather
//
//  Created by JJ Doleweerd on 2021-07-15.
//

import Foundation

struct WeatherResponse: Decodable {
    var main: Weather?
    var wind: Wind?
}

struct Weather: Decodable {
    var temp: Double?
    var humidity: Double?
}

struct Wind: Decodable {
    var speed: Double?
}
