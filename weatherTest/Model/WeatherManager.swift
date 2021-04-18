//
//  NetworkManager.swift
//  weatherTest
//
//  Created by Renzo Paul Chamorro on 17/04/21.
//

import Foundation

class WeatherManager: ObservableObject {
    
    
    @Published var weather = WeatherModel(cityName: "", temperature: 0, conditionID: 0)
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6394cbbfe3fe4aa9d877940208b2f12c&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func fetchWeather(latitude: Double, longitude: Double) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    print("error al obtener datos de url: \(error as Any)")
                } else {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(WeatherResults.self, from: safeData)
                            let name = results.name
                            let temp = results.main.temp
                            let conditionId = results.weather[0].id
                            let resultWeather = WeatherModel(cityName: name, temperature: temp, conditionID: conditionId)
                            DispatchQueue.main.async {
                                self.weather = resultWeather
                            }
                            print(resultWeather)
                            
                        } catch {
                            print("error al decodificar JSON: \(error as Any)")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}
