//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/14/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import Foundation

class ForecaseViewModel {
    let forecastData: ForecastModel
    private(set) var weatherData: [WeaterViewModel] = []
    private(set) var cityName = ""
    
    
    init(forecastData: ForecastModel) {
        self.forecastData = forecastData
        updateProperties()
    }
    
    private func updateProperties() {
        
        cityName = setCityName(forecastData: forecastData)
        weatherData = setWeatherData(forecastData: forecastData)
    }
    
    private func setWeatherData(forecastData: ForecastModel) -> [WeaterViewModel]{
        
        
        var weatherModel: CurrentWeatherModel
        var weatherVM: [WeaterViewModel] = []
        for forecast in forecastData.list{
            let weather = forecast.weather
            let dt = forecast.dt
            let main = forecast.main
            let name = setCityName(forecastData: forecastData)
           // let dateFormatter = DateFormatter()
            let timeZone = forecastData.city.timezone
            let sunset =  065655
            let sunrise =  065655
           // weatherModel = CurrentWeatherModel(weather: <#T##[Weather]#>, main: <#T##Main#>, dt: <#T##Int#>, sys: <#T##Sys#>, name: <#T##String#>, timezone: <#T##Int#>)
            weatherModel = CurrentWeatherModel(weather: weather, main: main, dt: dt, sys: Sys(sunrise: sunrise, sunset: sunset), name: name, timezone: timeZone)
            let weatherViewModelData = WeaterViewModel(currentWeather: weatherModel)
            weatherVM.append(weatherViewModelData)
        }
        
        return weatherVM
        
        
    }
    
    private func setCityName(forecastData: ForecastModel) -> String{
        return forecastData.city.name
    }
    
    
    
    
    
    
}

