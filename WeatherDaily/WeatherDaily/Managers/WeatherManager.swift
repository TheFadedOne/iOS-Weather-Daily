//
//  WeatherManager.swift
//  WeatherDaily
//
//  Created by Blackwell, Andrew on 6/19/23.
//

import Foundation

class WeatherManager: NSObject, ObservableObject {
    
    let apiKey: String = "5YHMAQDXMQPMD38ETR8U2BJCG"
    @Published var location: String?
    @Published var isLoading: Bool = false
    
    func getCurrentWeather(location: String?) async throws -> ResponseBody {
        let weatherLocation = location ?? "New York"
        guard let url = URL(string: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(weatherLocation)/today?iconSet=icons2&unitGroup=us&include=current&key=\(apiKey)&contentType=json")
        else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        return decodedData
        
    }
    
    func setLocation(_ location: String) {
        self.location = location
    }
}

struct ResponseBody: Decodable {
    var currentConditions: CurrentConditions
    var address: String
    var resolvedAddress: String
    
    struct CurrentConditions: Decodable {
        var feelslike: Double
        var temp: Double
        var icon: String
        var conditions: String
    }
    
}

