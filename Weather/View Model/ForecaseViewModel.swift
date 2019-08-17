//
//  ForecaseViewModel.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/14/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import Foundation

struct Forecast {
    <#fields#>
}
let forecastData: ForecastModel

init(currentWeather: CurrentWeatherModel) {
    self.currentWeather = currentWeather
    updateProperties()
}
