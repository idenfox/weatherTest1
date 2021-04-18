//
//  ContentView.swift
//  weatherTest
//
//  Created by Renzo Paul Chamorro on 17/04/21.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var textFieldCityName: String = ""
    @ObservedObject var weatherManager = WeatherManager()
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack (alignment: .topLeading){
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack (alignment: .trailing, spacing: 0) {
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(colorScheme == .dark ? Color.black : Color.white)
                        .frame(height: 45)
                        .overlay(
                            TextField("Ingrese Ciudad", text: $textFieldCityName)
                            { isEditing in
                            } onCommit: {
                                weatherManager.fetchWeather(cityName: textFieldCityName.trimmingCharacters(in: .whitespacesAndNewlines))
                            }
                            .padding()
                        )
                    Button(action: {
                        weatherManager.fetchWeather(latitude: self.locationManager.location.latitude, longitude: self.locationManager.location.Longitude)
                    }, label: {
                        Image(systemName: "location.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    })
                }
                Image(systemName: weatherManager.weather.conditionName)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding(.top)
                Text(weatherManager.weather.temperatureString)
                    .font(Font.custom("FredokaOne-Regular", size: 120))
                Text(weatherManager.weather.cityName)
                    .font(Font.custom("FredokaOne-Regular", size: 30))
            }
            .padding(.all)
        }
        .onAppear(perform: {
            weatherManager.fetchWeather(cityName: "Lima")
            self.locationManager.start()
        })
        .onTapGesture {
            self.endTextEditing()
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .preferredColorScheme(.light)
            MainView()
                .preferredColorScheme(.dark)
        }
    }
}

struct placeholderColor {
    let atributedPlaceholder = NSAttributedString(string: "placeholder text",
                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow])
}
