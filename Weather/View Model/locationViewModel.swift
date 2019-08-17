//
//  locationViewModel.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/15/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import Foundation

protocol locationUpdateDelegate: class {
    func updateCityName(city: String)
    func updateLocation(Lat: Double, Long: Double)
    }




//
//
//}
