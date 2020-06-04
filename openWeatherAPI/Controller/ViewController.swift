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
        newTextField.placeholder = "Enter City"
        newTextField.autocapitalizationType = .words
        newTextField.returnKeyType = .go
        newTextField.borderStyle = UITextField.BorderStyle.roundedRect
        newTextField.translatesAutoresizingMaskIntoConstraints = false
        return newTextField
    }()
    
    let tempLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.textAlignment = .center
        newLabel.font = UIFont(name: "Helvetica", size: 50)
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    let cityLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.textAlignment = .center
        newLabel.font = UIFont(name: "Helvetica", size: 30)
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
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
        textField.text = ""
        
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        fetchPokemonList(url: url)
        textField.delegate = self
        view.addSubview(image)
        view.addSubview(textField)
        view.addSubview(tempLabel)
        view.addSubview(cityLabel)
        
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: textField.topAnchor, constant: 40),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            //            tempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            //            tempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 20)
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
                
                
                
                let weather = WeatherModel(conditionId: weatherId, cityName: (data?.name)!, temperature: (data?.main?.temp)!)
                
                print(weather.getTemp)
                //                print(weather.conditionName)
                self.tempLabel.text = weather.getTemp
                self.cityLabel.text = data?.name
                
                self.image.image = UIImage(systemName: weather.conditionName)
                
            case let .failure(someError):
                print(someError)
            }
        }
        
    }
    
}

