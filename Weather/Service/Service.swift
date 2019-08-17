//
//  Service.swift
//  ComcastTest
//
//  Created by Apoorva Reed(Personal) on 6/23/19.
//  Copyright © 2019 Apoorva Reed(Personal). All rights reserved.
//

import Foundation

class Service: NSObject{
    
    
    
    
    
    static let shared = Service()

    
    
    

    
    func getforeCastAPI() -> String{
        if(Location.shared.city != nil){
            
            return "http://api.openweathermap.org/data/2.5/forecast?q=\(Location.shared.city!)&mode=json&APPID=d5f578d7c873a9eb501c9ad37f0cf095"
        }else if(Location.shared.latitude != nil){
            return "http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.shared.latitude!)&lon=\(Location.shared.longitude!)&mode=json&APPID=d5f578d7c873a9eb501c9ad37f0cf095"
        }else{
    return "http://api.openweathermap.org/data/2.5/weather?lat=0&lon=0&APPID=d5f578d7c873a9eb501c9ad37f0cf095"
    }
    }
    
    func getCurrentWeatherAPI() -> String{
        if(Location.shared.city != nil){
        
            return "http://api.openweathermap.org/data/2.5/weather?q=\(Location.shared.city!)&APPID=d5f578d7c873a9eb501c9ad37f0cf095"
        }else if(Location.shared.latitude != nil){
            return "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.shared.latitude!)&lon=\(Location.shared.longitude!)&APPID=d5f578d7c873a9eb501c9ad37f0cf095"
        }else{
            return "http://api.openweathermap.org/data/2.5/weather?lat=0&lon=0&APPID=d5f578d7c873a9eb501c9ad37f0cf095"
        }
        
    }
    
    
    
    

    
    /*
     Author: Apoorva Reed
     created: 07/26/2019
     func name: fetchData
     functionality: to fetch json data into models
     
     */
    //CurrentWeatherModel
    
    func fetchForecastData(completion: @escaping (ForecastModel?, Error?) -> ()) {
        
        
        
        var urlString: String
        
        urlString = getforeCastAPI()
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            
            // check response
            
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode(ForecastModel.self, from: data)
                DispatchQueue.main.async {
                    completion(courses, nil)
                }
            } catch let jsonErr {
                completion(nil, jsonErr)
            }
            }.resume()
    }
    
    func fetchData(completion: @escaping (CurrentWeatherModel?, Error?) -> ()) {
        
        
        var urlString: String
        
        
        
        urlString = getCurrentWeatherAPI()
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        

        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                
                return
            }
            
            // check response
            
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode(CurrentWeatherModel.self, from: data)
                DispatchQueue.main.async {
                    completion(courses, nil)
                }
            } catch let jsonErr {
                completion(nil, jsonErr)
                
            }
            }.resume()
    }
    
}
