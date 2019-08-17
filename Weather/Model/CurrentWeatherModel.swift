//
//  CurrentWeatherModel.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/14/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import Foundation




struct CurrentWeatherModel: Decodable{
    let weather: [Weather]
    let main: Main
    let dt: Int
    let sys: Sys
//    let timezone: Int
     let name: String
    let timezone: Int
 
}


struct Main: Codable {
    let temp: Double
    let tempMin, tempMax: Double
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
 
}

struct Sys: Codable{
    let sunrise: Int
    let sunset: Int
}


struct Weather: Codable {
    let id: Int
    let main, description: String
    

}
