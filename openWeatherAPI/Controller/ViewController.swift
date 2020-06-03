//
//  ViewController.swift
//  openWeatherAPI
//
//  Created by Cao Mai on 6/3/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let url = "http://api.openweathermap.org/data/2.5/weather?q=London&appid=d072d1f873cfe8c47504da0394e43466"
        
    let network = NetworkLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        
//        fetchPokemonList(url: url)
        fetchWeather(city: "Paris")
    }
    
    
    func fetchWeather(city: String) {
        network.getWeatherData(passedInQuery: city) { result in

            switch result {
            case let .success(weather):
                print(weather?.name!)
            case let .failure(someError):
                print(someError)
            }
        }
        
    }
    
}

