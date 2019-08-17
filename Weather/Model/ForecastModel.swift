//
//  ForecastModel.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/14/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import Foundation



struct ForecastModel: Codable {
    let list: [List]
    let city: City
}


struct City: Codable {
    let name: String
    let coord: Coord
    let country: String
    let timezone: Int
    
}


struct Coord: Codable {
    let lat, lon: Double
}


struct List: Codable {
    
    let dt: Int
    let main: Main
    let weather: [Weather]
    let dt_txt: String
    
   
    
    
    
}

