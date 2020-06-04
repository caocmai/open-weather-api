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
    
    let image: UIImageView = {
        let newImage = UIImageView()
        newImage.contentMode = .scaleAspectFit
        newImage.translatesAutoresizingMaskIntoConstraints = false
        return newImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        fetchPokemonList(url: url)
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        image.image = UIImage(systemName: "cloud.fill")
//        image.image = UIImage(named: "test")
        fetchWeather(city: "Paris")
        view.backgroundColor = .white
    }
    
    
    func fetchWeather(city: String) {
        network.getWeatherData(passedInQuery: city) { result in

            switch result {
            case let .success(data):
//                print(weather?.weather.description)
                let weatherId = data!.weather[0].id!

                let weatherCondition = data!.weather[0].description
                print(weatherCondition)
    
                let weather = WeatherModel(conditionId: weatherId, cityName: (data?.name)!, temperature: (data?.main?.temp)!)
                
                print(weather.getTemp)
                print(weather.conditionName)
            case let .failure(someError):
                print(someError)
            }
        }
        
    }
    
}

