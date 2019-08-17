//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Apoorva Reed(Personal) on 8/13/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherViewModel() {
        
        let main = Main(temp: 23.3, tempMin: 19.5, tempMax: 24.0)
        let sys = Sys(sunrise: 1566036574, sunset: 1566086012)
        let weather: [Weather] = [Weather(id: 3, main: "Clear", description: "Clear Sky"), Weather(id: 3, main: "Clear", description: "Clear Sky")]
        let currentWeatehr = CurrentWeatherModel(weather: weather, main: main, dt: 1566054761, sys: sys, name: "Newark", timezone: -14400)
        
        let currentViewModels = WeaterViewModel(currentWeather: currentWeatehr)
        XCTAssertEqual(currentViewModels.dayNight, "Morning")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
