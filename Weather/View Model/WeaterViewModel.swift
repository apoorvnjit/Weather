//
//  WeaterViewModel.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/14/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import Foundation


class WeaterViewModel: locationUpdateDelegate{
    func updateCityName(city: String) {
        Location.shared.city = city
    }
    func updateLocation(Lat: Double, Long: Double){
        Location.shared.latitude = Lat 
        Location.shared.longitude = Long 
    }
    
   
    

    let currentWeather: CurrentWeatherModel
    private(set) var cityName = ""
    private(set) var weatherType = ""
    private(set) var tempC = "0.0"
    private(set) var tempF = "0.0"
    private(set) var dt: Double = 0
    private(set) var timeZone: Int = 0
    private(set) var dayNight: String = "Morning"
    private(set) var sunrise: Date = Date()
    private(set) var sunset: Date = Date()
    private var model: ViewController!
    
    
    init(currentWeather: CurrentWeatherModel) {
        
        self.currentWeather = currentWeather
        updateProperties()
        
        
        
    }
    

    private func updateProperties() {
        
        timeZone = setTimeZone(currentWeather: currentWeather)
        cityName = setCityName(currentWeather: currentWeather)
        
        tempF = setTempF(currentWeather: currentWeather)
        tempC = setTempC(currentWeather: currentWeather)
        dt = setdt(currentWeather: currentWeather)
        sunrise = setsunrise(currentWeather: currentWeather)
        sunset = setsunset(currentWeather: currentWeather)
        dayNight = setBackgroundImage(currentWeather: currentWeather)
        weatherType = setWeatherType(currentWeather: currentWeather)
        
    }
    
    func setDelegates(){
        model.delegate = self
    }
    
    private func setTimeZone(currentWeather: CurrentWeatherModel) -> Int{
        return currentWeather.timezone
    }
    private func setBackgroundImage(currentWeather: CurrentWeatherModel) -> String{
        
        let sunriseTime = Double(currentWeather.sys.sunrise)
        let sunsetTime = Double(currentWeather.sys.sunset)
        let date = Double(currentWeather.dt)
        let rawData = Date(timeIntervalSince1970: date)
        let sunRise = Date(timeIntervalSince1970: sunriseTime)
        let sunSet = Date(timeIntervalSince1970: sunsetTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if((sunRise < rawData) && (sunSet > rawData)){
            return "Morning"
        }else{
            return "Night"
        }
        
        
    }
    private func setdt(currentWeather: CurrentWeatherModel) -> Double{
        
        let date = Double(currentWeather.dt)
        return date
        
        
    }
    
    private func setsunrise(currentWeather: CurrentWeatherModel) -> Date{
        
        let date = Double(currentWeather.sys.sunrise)
        let rawData = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let getdate = dateFormatter.string(from: rawData)
        return dateFormatter.date(from: getdate)!
        
        
        
        
    }
    
    private func setsunset(currentWeather: CurrentWeatherModel) -> Date{
        
        let date = Double(currentWeather.sys.sunset)
        let rawData = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let getdate = dateFormatter.string(from: rawData)
        return dateFormatter.date(from: getdate)!
    }
    
    private func setCityName(currentWeather: CurrentWeatherModel) -> String{
        return currentWeather.name
    }
    
    private func setWeatherType(currentWeather: CurrentWeatherModel) -> String{
        
        let weatherData = currentWeather.weather[0].main
        if(dayNight == "Night" && weatherData == "Clear"){
                return "Clear Sky"
        }
        return currentWeather.weather[0].main
    }
    private func setTempF(currentWeather: CurrentWeatherModel) -> String{
        let kelvinTemp = currentWeather.main.temp
        let temperature:Double = round(Utility.shared.convertKelvinToFahrenheit(temperatureKelvin: kelvinTemp))
        return String("\(Int(temperature))°F")
    }
    private func setTempC(currentWeather: CurrentWeatherModel) -> String{
        let kelvinTemp = currentWeather.main.temp
        let temperature:Double = round(Double(Utility.shared.convertKelvinToCelcius(temperatureKelvin: kelvinTemp)))
        return String("\(Int(temperature))°C")
    }
    
    
    
   
    
}






