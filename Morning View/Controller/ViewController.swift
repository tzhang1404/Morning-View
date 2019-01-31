//
//  ViewController.swift
//  Morning View
//
//  Created by Tony Zhang on 12/7/18.
//  Copyright © 2018 Tony Zhang. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //API request core data
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "5ac00b4b8084dfde07646645509e2a73"
    
    let greetingModel = greetingLogicModel();
    let locationManager = CLLocationManager();
    let weatherDataModel = weatherModel();
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var greetText: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //prepare the greeting text
        greetingModel.greetingLogic();
        greetText.text = greetingModel.greeting;
        //set lM's delegate to viewcontroller itself and prepare accuracy
        locationManager.delegate = self;
        prepareLocManager();
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - JSON Processing
    /***************************************************************/
    func updateWeatherData(json : JSON){
        if let tempResult = json["main"]["temp"].double{
            weatherDataModel.temperature = Int(tempResult - 273.5);
            weatherDataModel.condition = json["weather"][0]["id"].intValue;
            weatherDataModel.city = json["name"].stringValue;
            
            //change weather data icon
            
            updateWeatherUI();
        }
        else{
            cityLabel.text = "Error";
        }
    }
    
    //MARK: - Networking with OpenWeatherApp
    /***************************************************************/
    func getWeatherData(url : String, parameters : [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{
            response in
            if(response.result.isSuccess){
                print("weather data acquired");
                let weatherJSON : JSON = JSON(response.result.value!);
                print(weatherJSON);
                //update weather data and parse JSON
                self.updateWeatherData(json: weatherJSON);
            }
            else{
                print("There is an error, the problem is \(response.result.error)");
                self.cityLabel.text = "Connection Issues";
            }
        }
    }
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    func prepareLocManager(){
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        //ask the user for permission to get the current location of the user
        locationManager.requestWhenInUseAuthorization(); //the method that will trigger the authorization popup
        locationManager.startUpdatingLocation(); //work in background, looking for the GPS coordinate, will send a message to the viewController
    }
    
    
    //when location is acquired
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let finalLocation = locations[locations.count - 1]; //get the last (most accurate) location
        if(finalLocation.horizontalAccuracy > 0){
            locationManager.stopUpdatingLocation();
            locationManager.delegate = nil;
            
            let longtitude : String = String(finalLocation.coordinate.longitude);
            let latitude : String = String(finalLocation.coordinate.latitude);
            
            //prepare dictionary
            let params : [String : String] = ["lat" : latitude, "lon" : longtitude, "APPID" : APP_ID];
            
            //get weather data here
            getWeatherData(url: WEATHER_URL, parameters: params);
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error);
        cityLabel.text = "Unavailable";
    }
    
    
    
    //MARK: - UI Updates once data is acquired
    /***************************************************************/
    
    func updateWeatherUI(){
        cityLabel.text = weatherDataModel.city;
        temperatureLabel.text = "\(weatherDataModel.temperature)°C";
        //implemen weather data condition
        weatherIcon.image = UIImage(named: weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition));
    }
    
}

