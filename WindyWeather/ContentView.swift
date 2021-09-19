//
//  ContentView.swift
//  WindyWeather
//
//  Created by JJ Doleweerd on 2021-07-15.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    init(){
        self.weatherVM = WeatherViewModel()
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer(minLength: 20)
            
            TextField("Enter City Name", text: self.$weatherVM.cityName, onCommit:  {
                self.weatherVM.search()
            })
                .font(.title)
                .background(Color.white)
                .padding(.all, 12)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer(minLength: 30)
            
            if (self.weatherVM.temperature != ""){
                startView()
                Spacer(minLength: 10)
                resultsView(weatherVM: self.weatherVM)
                Spacer(minLength: 30)
            } else {
                startView()
                Spacer(minLength: 15)
                Image(systemName: "questionmark.square")
                    .font(.custom("Arial", size: 310))
                    .background(Color.white)
                    .cornerRadius(10.0)
                Spacer(minLength: 30)
            }

        }
        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
        .background(Color.secondary)
        .cornerRadius(10.0)
        .padding()

    }
}

struct startView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "cloud.sun")
                .font(.custom("Arial", size: 200))
                .padding(.trailing, 50)
            
            Text("Welcome to Windy Weather")
                .padding(.top, 20)
                .font(.title2)
            
            Text("Find out if today is a good day to sail!")
                .padding(.all, 12)
                .font(.custom("Arial", size: 20))
                .lineLimit(nil)
            
        }
        .background(Color.white)
        .cornerRadius(10.0)
        
    }
}

struct resultsView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            if (self.weatherVM.goodToSailBool) {
            Image(systemName: "wind")
                .font(.custom("Arial", size: 150))
                .padding(.all, 12)
            } else {
                Image(systemName: "slash.circle")
                    .font(.custom("Arial", size: 150))
                    .padding(.all, 12)
            }
            Text(self.weatherVM.cityName.capitalized)
                .padding(.top, 20)
                .font(.title2)
            
            Text(self.weatherVM.goodToSail)
                .padding(.all, 12)
                .font(.custom("Arial", size: 20))
                .lineLimit(nil)
            
        }
        .background(Color.white)
        .cornerRadius(10.0)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
