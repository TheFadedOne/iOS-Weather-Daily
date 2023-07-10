//
//  ContentView.swift
//  WeatherDaily
//
//  Created by Blackwell, Andrew on 6/15/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @State var isRecording: Bool = false
    @State var url: URL?
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .teal]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            
            if let location = weatherManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(location: location)
                            } catch {
                                print("Error fetching data: \(error)")
                            }
                        }
                }
            } else {
                if weatherManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(weatherManager)
                }
            }
        }.overlay(alignment: .bottomTrailing,content: {
            Button {
                if isRecording {
                    Task{
                        do {
                            self.url = try await stopRecording()
                            print(self.url)
                            isRecording = false
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    startRecording{
                        error in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        
                        //Success
                        isRecording = true
                    }
                }
            } label: {
                Image(systemName: isRecording ? "record.circle.fill" : "rectangle.dashed.badge.record")
                    .font(.largeTitle)
                    .foregroundColor(isRecording ? .red : .black)
            }
            .padding()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
