//
//  DailyForecastViewModel.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/15/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import Foundation
struct dailyWeatherModels{
    let data: [[todaysData]]
}

class DailyForecastViewModel {
    let forecastData: ForecastModel
//    let dailyWeather: dailyWeatherModels
    private(set) var dailyWeather: [[todaysData]] = []
    private(set) var timeZone: Int = 0
    private(set) var lowTemp: Double = 80000.0
    private(set) var highTemp: Double = -80000.0
    
    init(forecastData: ForecastModel) {
        self.forecastData = forecastData
        //self.dailyWeather = dailyWeather
        updateProperties()
    }
    
    
    private func updateProperties() {
        
        timeZone = setTimeZone(forecastData: forecastData)
        dailyWeather = setDailyWeather(forecastData: forecastData)
        
        //weatherData = setWeatherData(forecastData: forecastData)
    }
    
    func setTimeZone(forecastData: ForecastModel) -> Int{
        
        return forecastData.city.timezone
    }
    
    func getDate(date: Double, timeZone: Int) -> Date{
        let rawDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .long
//        dateFormatter.timeStyle = .long
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        dateFormatter.locale = .current
        let formatString = dateFormatter.string(from: rawDate)

        
        let formatdate = DateFormatter()
        formatdate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatdate.timeZone = TimeZone(secondsFromGMT: 0)
        
        
        
        return (formatdate.date(from: formatString)!)
    }
    
    func getSpecificDate(rawDate: Date) -> Date{
        //let rawDate = Date(timeIntervalSince1970: date)
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formatString = dateFormatter.string(from: rawDate)
        return dateFormatter.date(from: formatString)!

    }
    
    func getSpecificDay(rawDate: Date) -> String{
        //let rawDate = Date(timeIntervalSince1970: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: rawDate)
        
    }
    
    func getTime(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        let getdate = dateFormatter.string(from: date)
        return getdate
    }
    
    private func setDailyWeather(forecastData: ForecastModel) -> [[todaysData]]{
        var todayData: [[todaysData]] = []
       // var weatherModel: CurrentWeatherModel
        var dailyModel: [todaysData] = []
       // var weatherVM: [WeaterViewModel] = []
        let currDt = Double(forecastData.list[0].dt)
        var currentDate: Date = getDate(date: currDt, timeZone: forecastData.city.timezone)
        
        var nextDate: Date
        for (idx, forecast) in forecastData.list.enumerated(){
            //let weather = forecast.weather
            let dt = Double(forecast.dt)
            let main = forecast.main
            //let name = setCityName(forecastData: forecastData)
            let timeZone = forecastData.city.timezone
            
            nextDate = getDate(date:dt,timeZone: timeZone)
            
            lowTemp = (lowTemp<forecast.main.tempMin) ? lowTemp : forecast.main.tempMin
            highTemp = (highTemp>forecast.main.tempMax) ? highTemp : forecast.main.tempMax
            
            let dtnextDate = getSpecificDate(rawDate: nextDate)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM,dd"
            let stringDate = dateFormatter.string(from: dtnextDate)
            
            if(getSpecificDate(rawDate: nextDate)>getSpecificDate(rawDate: currentDate)){
                
                todayData.append(dailyModel)
                dailyModel = []
               dailyModel.append(todaysData(time: getTime(date: nextDate), tempC: String("\(convertKelvinToCelcius(temperatureKelvin: main.temp))°C"), tempF: String("\(convertKelvinToFahrenheit(temperatureKelvin: main.temp))°F"), weather: forecast.weather[0].main, date: stringDate, day: getSpecificDay(rawDate: dtnextDate), lowTempF: String("\(convertKelvinToFahrenheit(temperatureKelvin: lowTemp))°F"), highTempF: String("\(convertKelvinToFahrenheit(temperatureKelvin: highTemp))°F"), lowTempC: String("\(convertKelvinToCelcius(temperatureKelvin: lowTemp))°C"), highTempC: String("\(convertKelvinToCelcius(temperatureKelvin: highTemp))°C")))
                lowTemp = 80000.00
                highTemp = -800000
            }else{
                
                
              dailyModel.append(todaysData(time: getTime(date: nextDate), tempC: String("\(convertKelvinToCelcius(temperatureKelvin: main.temp))°C"), tempF: String("\(convertKelvinToFahrenheit(temperatureKelvin: main.temp))°F"), weather: forecast.weather[0].main, date: stringDate, day: getSpecificDay(rawDate: dtnextDate), lowTempF: String("\(convertKelvinToFahrenheit(temperatureKelvin: lowTemp))°F"), highTempF: String("\(convertKelvinToFahrenheit(temperatureKelvin: highTemp))°F"), lowTempC: String("\(convertKelvinToCelcius(temperatureKelvin: lowTemp))°C"), highTempC: String("\(convertKelvinToCelcius(temperatureKelvin: highTemp))°C")))
            }
            currentDate = getDate(date: dt,timeZone: forecastData.city.timezone)
            
            if(idx == forecastData.list.endIndex ){
                todayData.append(dailyModel)
            }
            
//            dailyModel.append(todaysData(time: <#T##String#>, temp: <#T##Double#>, weather: <#T##String#>))
//            weatherModel = CurrentWeatherModel(weather: weather, main: main, dt: dt, name: name, timezone: timeZone)
//            let weatherViewModelData = WeaterViewModel(currentWeather: weatherModel)
//            weatherVM.append(weatherViewModelData)
            
            
        }
        
        return todayData
        
        
    }
    
     func convertKelvinToFahrenheit(temperatureKelvin: Double) -> Int {
        let temp: Double = (temperatureKelvin - 273)
        let dividend: Double = 9/5
        return Int((temp * dividend) + 32)
    }
    
    func convertKelvinToCelcius(temperatureKelvin: Double) -> Int {
        let temp: Double = (temperatureKelvin - 273.15)
        return Int(temp )
    }
    
    
}
enum weather: String{
    case Clouds = "clouds"
    case MornClear = "sun"
    case NightClear = "moon"
    case Mist = "mist"
    case Snow = "snow"
    case Rain, Drizzle = "showerrain"
    case Thunderstorm = "thunderstorm"
    
}
struct todaysData{
    var time: String
    var tempC: String
    var tempF: String
    var weather: String
    var date: String
    var day: String
    var lowTempF: String
    var highTempF: String
    var lowTempC: String
    var highTempC: String
    
    init(time: String, tempC: String, tempF: String,  weather: String, date: String, day: String, lowTempF: String, highTempF: String, lowTempC: String, highTempC: String) {
        self.time = time
        self.tempC = tempC
        self.tempF = tempF
        self.weather = weather
        self.date = date
        self.day = day
        self.highTempF = highTempF
        self.lowTempF = lowTempF
        self.lowTempC = lowTempC
        self.highTempC = highTempC
    }
}
