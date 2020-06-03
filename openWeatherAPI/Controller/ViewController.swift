//
//  ViewController.swift
//  openWeatherAPI
//
//  Created by Cao Mai on 6/3/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    let network = NetworkLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        fetchPokemonList(url: url)
        fetchWeather(city: "Paris")
    }
    
    
    func fetchWeather(city: String) {
        network.getWeatherData(passedInQuery: city) { result in

            switch result {
            case let .success(weather):
                print(weather?.weather.description)
            case let .failure(someError):
                print(someError)
            }
        }
        
    }
    
}

