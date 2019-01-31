//
//  weatherModel.swift
//  Morning View
//
//  Created by Tony Zhang on 1/24/19.
//  Copyright © 2019 Tony Zhang. All rights reserved.
//

import Foundation

class weatherModel{
    var temperature : Int;
    var condition : Int;
    var city : String;
    var weatherIcon : String;
    
    init(){
        temperature = 0;
        condition = 0;
        city = "";
        weatherIcon = "";

    }
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "sun"
        }
        
    }
    
}
