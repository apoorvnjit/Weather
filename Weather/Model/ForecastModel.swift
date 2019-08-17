//
//  ForecastModel.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/14/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import Foundation


// MARK: - ForecastModel
struct ForecastModel: Codable {
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let name: String
    let coord: Coord
    let country: String
    let timezone: Int
    
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct List: Codable {
    
    let dt: Int
    let main: Main
    let weather: [Weather]
    let dt_txt: String
    
   
    
    
    
}


//
//// MARK: - MainClass
//struct MainClass: Codable {
//    let temp, tempMin, tempMax: Double
//
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case tempMin
//        case tempMax
//    }
//}



//// MARK: - Weather
//struct WeatherData: Codable {
//    let id: Int
//    let main: String
//    let weatherDescription: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, main
//        case weatherDescription
//
//    }
//}
