//
//  ViewController.swift
//  openWeatherAPI
//
//  Created by Cao Mai on 6/3/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
        
    let network = NetworkLayer()
    
    let image: UIImageView = {
        let newImage = UIImageView()
        newImage.contentMode = .scaleAspectFit
        newImage.translatesAutoresizingMaskIntoConstraints = false
        return newImage
    }()
    
    let textField: UITextField = {
        let newTextField = UITextField()
        newTextField.placeholder = "Weather City"
        newTextField.autocapitalizationType = .words
        newTextField.returnKeyType = .go
        newTextField.borderStyle = UITextField.BorderStyle.roundedRect
        newTextField.translatesAutoresizingMaskIntoConstraints = false
        return newTextField
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        var properSearchQuery = ""
               for letter in textField.text! {
                   if letter == " " {
                       properSearchQuery += "%20" // To deal with space
                   }else {
                       properSearchQuery += String(letter)
                   }
               }
        
        fetchWeather(city: properSearchQuery)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        fetchPokemonList(url: url)
        textField.delegate = self
        view.addSubview(image)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

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
//                print(weather.conditionName)
                self.image.image = UIImage(systemName: weather.conditionName)

            case let .failure(someError):
                print(someError)
            }
        }
        
    }
    
}

