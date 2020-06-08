//
//  ViewController.swift
//  openWeatherAPI
//
//  Created by Cao Mai on 6/3/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
        
    let image: UIImageView = {
        let newImage = UIImageView()
        newImage.contentMode = .scaleAspectFit
        newImage.translatesAutoresizingMaskIntoConstraints = false
        return newImage
    }()
    
    let cityInput: UITextField = {
        let newTextField = UITextField()
        newTextField.placeholder = "Enter City"
        newTextField.autocapitalizationType = .words
        newTextField.returnKeyType = .go
        newTextField.borderStyle = UITextField.BorderStyle.roundedRect
        newTextField.translatesAutoresizingMaskIntoConstraints = false
        return newTextField
    }()
    
    let moodInput: UITextField = {
        let newTextField = UITextField()
        newTextField.placeholder = "Enter Mood"
        newTextField.autocapitalizationType = .words
        newTextField.returnKeyType = .go
        newTextField.borderStyle = UITextField.BorderStyle.roundedRect
        newTextField.translatesAutoresizingMaskIntoConstraints = false
        return newTextField
    }()
    
    let moodLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.textAlignment = .center
        newLabel.font = UIFont(name: "Helvetica", size: 30)
        newLabel.textColor = .darkGray
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
    }()
    
    let weatherDescriptionLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.textAlignment = .center
        newLabel.font = UIFont(name: "Helvetica", size: 20)
        newLabel.textColor = .darkGray
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        return newLabel
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
        
        if textField.tag == 1 {
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
        } else if textField.tag == 2 {
            moodLabel.text = "Today's mood is \(textField.text!)"
        }
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Current Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchWeather(city: "San%20Francisco")
        view.backgroundColor = .white
        configureUI()
    }
    
    func configureUI() {
        cityInput.delegate = self
        cityInput.tag = 1
        moodInput.delegate = self
        moodInput.tag = 2
        view.addSubview(image)
        view.addSubview(weatherDescriptionLabel)
        view.addSubview(cityInput)
        view.addSubview(tempLabel)
        view.addSubview(cityLabel)
        view.addSubview(moodLabel)
        view.addSubview(moodInput)
        
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: cityInput.topAnchor, constant: 40),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherDescriptionLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            cityInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            //            tempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            //            tempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            moodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moodLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
    
        ])
        
        NSLayoutConstraint.activate([
            moodInput.leadingAnchor.constraint(equalTo: cityInput.trailingAnchor, constant: 5),
            moodInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4)

        ])
    }
    
    
    func fetchWeather(city: String) {
        NetworkLayer.getWeatherData(cityName: city) { result in
            
            switch result {
            case let .success(data):
                //                print(weather?.weather.description)
                let weatherId = data!.weather[0].id!
                
                let weatherCondition = data!.weather[0].description
                self.weatherDescriptionLabel.text = weatherCondition
                let weather = WeatherModel(conditionId: weatherId, cityName: (data?.name)!, temperature: (data?.main?.temp)!)
                
                print(weather.getTemp)
//                                print(weather.conditionName)
                self.tempLabel.text = ("\(weather.getTemp) F")
                self.cityLabel.text = data?.name
                
                self.image.image = UIImage(systemName: weather.conditionName)
                
            case let .failure(someError):
                print(someError)
            }
        }
        
    }
    
}

