//
//  WeatherView.swift
//  WeatherDaily
//
//  Created by Blackwell, Andrew on 6/20/23.
//

import SwiftUI

struct WeatherView: View {
    
    //SF images
    let snow = Image(systemName: "cloud.snow.fill")
    let snowShowersDay = Image(systemName: "cloud.snow.fill")
    let snowShowersNight = Image(systemName: "cloud.snow.fill")
    let thunderRain = Image(systemName: "cloud.bolt.rain.fill")
    let thunderShowersDay = Image(systemName: "cloud.sun.bolt.fill")
    let thunderShowersNight = Image(systemName: "cloud.moon.bolt.fill")
    let showersDay = Image(systemName: "cloud.sun.rain.fill")
    let showersNight = Image(systemName: "cloud.moon.rain.fill")
    let fog = Image(systemName: "cloud.fog.fill")
    let wind = Image(systemName: "wind")
    let cloudy = Image(systemName: "cloud.fill")
    let partlyCloudyDay = Image(systemName: "cloud.sun.fill")
    let partlyCloudyNight = Image(systemName: "cloud.moon.fill")
    let clearDay = Image(systemName: "sun.max.fill")
    let clearNight = Image(systemName: "moon.stars.fill")
    let unknown = Image(systemName: "questionmark.app")
    
    var weather: ResponseBody
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .teal]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    Text(weather.address)
                        .foregroundColor(Color.white)
                        .bold()
                        .font(.system(size: 40))
                    getWeatherImage(weatherIconDiscription: weather.currentConditions.icon)
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 90))
                }
                Text("\(weather.currentConditions.temp.roundDouble())°F")
                    .font(.system(size: 90))
                    .foregroundColor(Color.white)
                    .bold()
                Spacer()
            }
        }
    }
    
    init (weather: ResponseBody) {
        self.weather = weather
    }
    
    func getWeatherImage(weatherIconDiscription: String) -> Image {
        
        switch weatherIconDiscription {
        case "snow":
            return snow
        case "snow-showers-day":
            return snowShowersDay
        case "show-showers-night":
            return snowShowersNight
        case "thunder-rain":
            return thunderRain
        case "thunder-showers-day":
            return thunderShowersDay
        case "thunder-showers-night":
            return thunderShowersNight
        case "showers-day":
            return showersDay
        case "showers-night":
            return showersNight
        case "fog":
            return fog
        case "wind":
            return wind
        case "cloudy":
            return cloudy
        case "partly-cloudy-day":
            return partlyCloudyDay
        case "partly-cloudy-night":
            return partlyCloudyNight
        case "clear-day":
            return clearDay
        case "clear-night":
            return clearNight
        default:
            return unknown
        }
    }
}



struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
