//
//  ContentView.swift
//  weatherTest
//
//  Created by Renzo Paul Chamorro on 17/04/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var weatherManager = WeatherManager()
    @State private var textFieldCityName: String = ""
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                HStack {
                    TextField("Entra text", text: $textFieldCityName)
                    { isEditing in
                    } onCommit: {
                        weatherManager.fetchWeather(cityName: textFieldCityName)
                    }
                    Button(action: {
                        weatherManager.fetchWeather(latitude: self.locationManager.location.latitude, longitude: self.locationManager.location.Longitude)
                    }, label: {
                        Image(systemName: "location.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.black)
                    })
                }
                HStack {
                    Text(weatherManager.weather.temperatureString)
                        .padding()
                    Image(systemName: weatherManager.weather.conditionName)
                }
                .onAppear(perform: {
                    weatherManager.fetchWeather(cityName: "Lima")
                    self.locationManager.start()

                })
                
            }
            .padding()
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
