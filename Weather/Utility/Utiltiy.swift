//
//  Utiltiy.swift
//  Weather
//
//  Created by Apoorva Reed(Personal) on 8/16/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import Foundation
import UIKit

class Utility{
    
    static let shared = Utility()
    /*
     Author: Apoorva Reed
     created: 07/26/2019
     func name:
     functionality: to show alert with message
     */
    func alert(message: String, view: UIViewController){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    public func convertKelvinToFahrenheit(temperatureKelvin: Double) -> Double {
        let temp: Double = (temperatureKelvin - 273)
        let dividend: Double = 9/5
        return ((temp * dividend) + 32)
    }
    
    func convertKelvinToCelcius(temperatureKelvin: Double) -> Int {
        let temp: Double = (temperatureKelvin - 273.15)
        return Int(temp )
    }
}
