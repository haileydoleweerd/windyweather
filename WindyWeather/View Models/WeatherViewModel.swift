//
//  WeatherViewModel.swift
//  WindyWeather
//
//  Created by JJ Doleweerd on 2021-07-15.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    private var weatherService: WeatherService!
    
    @Published var weather = Weather()
    @Published var wind = Wind()
    
    var windThreshold: Double = 6.0
    var tempThreshold: Double = 12.0
    
    init() {
        self.weatherService = WeatherService()
    }
    
    var temperature: String {
        if let temp = self.weather.temp {
            return String(format: "%.0f", temp)
        } else {
            return ""
        }
    }
    
    var humidity: String {
        if let humidity = self.weather.humidity {
            return String(format: "%.0f", humidity)
        } else {
            return ""
        }
    }
    
    var windSpeed: String {
        if let windSpeed = self.wind.speed {
            return String(format: "%.0f", windSpeed)
        } else {
            return ""
        }
    }
    
    var goodToSail: String {
        if let windSpeed = self.wind.speed, let temp = self.weather.temp {
            if (windSpeed >= self.windThreshold && temp >= tempThreshold) {
                return "Today is a good day to set sail."
            } else {
                return "It is not a good day to set sail."
            }
        } else {
            return "It is not a good day to set sail."
        }
    }
    
    var goodToSailBool: Bool {
        if let windSpeed = self.wind.speed, let temp = self.weather.temp {
            if (windSpeed >= self.windThreshold && temp >= tempThreshold) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    var cityName: String = ""
    
    func search() {
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            fetchWeather(by: city)
            fetchWind(by: city)
        }
    }
    
    private func fetchWeather(by city: String) {
        self.weatherService.getWeather(city: city) {weather in
            if let weather = weather {
                DispatchQueue.main.async {
                    self.weather = weather
                }
            }
        }
    }
    
    private func fetchWind(by city: String) {
        self.weatherService.getWind(city: city) {wind in
            if let wind = wind {
                DispatchQueue.main.async {
                    self.wind = wind
                }
            }
        }
    }
    
}
