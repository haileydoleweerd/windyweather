//
//  WeatherService.swift
//  WindyWeather
//
//  Created by JJ Doleweerd on 2021-07-15.
//

import Foundation

class WeatherService {
    func getWeather(city: String, completion: @escaping (Weather?) -> ()) {
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?appid=de107821d9bc152ec1e0e6bc83cc38a7&q=\(city)&units=metric") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            
            if let weatherResponse = weatherResponse {
                let weather = weatherResponse.main
                completion(weather)
            } else {
                completion(nil)
            }
            
        }.resume()
        
    }
    func getWind(city: String, completion: @escaping (Wind?) -> ()) {
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?appid=de107821d9bc152ec1e0e6bc83cc38a7&q=\(city)&units=metric") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            
            if let weatherResponse = weatherResponse {
                let wind = weatherResponse.wind
                completion(wind)
            } else {
                completion(nil)
            }
            
        }.resume()
        
    }
}
