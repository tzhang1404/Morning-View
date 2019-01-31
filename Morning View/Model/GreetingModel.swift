//
//  GreetingLogic.swift
//  Morning View
//
//  Created by Tony Zhang on 1/23/19.
//  Copyright © 2019 Tony Zhang. All rights reserved.
//

import Foundation

class greetingLogicModel{
    var greeting : String;
    
    init() {
        greeting = "";
    }
    
    func greetingLogic(){
        let date = NSDate();
        let calendar = NSCalendar.current;
        let hour = calendar.component(.hour, from: date as Date)
        let hourNumber = Int(hour.description)!
        
        if(hourNumber >= 5 && hourNumber < 12){
            greeting = "Good Morning,"
        }
        else if(hourNumber >= 0 && hourNumber < 5){
            greeting = "Good Dream,"
        }
        else if(hourNumber >= 12 && hourNumber < 16){
            greeting = "Good Afternoon,"
        }
        else if(hourNumber >= 16 && hourNumber < 19){
            greeting = "Good Evening,"
        }
        else if(hourNumber >= 19 && hourNumber <= 24){
            greeting = "Good Night,"
        }
        
    }
}
