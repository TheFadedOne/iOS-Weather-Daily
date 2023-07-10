//
//  WelcomeView.swift
//  WeatherDaily
//
//  Created by Blackwell, Andrew on 6/29/23.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var location: String = ""
    @EnvironmentObject var weatherManager: WeatherManager
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Enter a location...").font(.system(size: 50)).padding(.all)
                    .foregroundColor(.white)
                    .bold()
                TextField("Location", text: $location)
                    .multilineTextAlignment(TextAlignment.center)
                    .font(.custom("ComicSans", size: 20)).padding(.all)
                    .underline()
                    .bold()
                Button("Get Weather", action: {
                    weatherManager.setLocation(self.location)
                    weatherManager.isLoading = true
                })
                Spacer()
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
