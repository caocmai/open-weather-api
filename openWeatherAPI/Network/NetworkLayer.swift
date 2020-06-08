//
//  NetworkLayer.swift
//  openWeatherAPI
//
//  Created by Cao Mai on 6/3/20.
//  Copyright © 2020 Make School. All rights reserved.
//

//http://api.openweathermap.org/data/2.5//weather?q=London&appid=d072d1f873cfe8c47504da0394e43466

import Foundation


class NetworkLayer {
    
    static let baseURL = "http://api.openweathermap.org/data/2.5/"
    static let urlSession = URLSession.shared
    static let APIKEY = "\(APIKeyPersonal.apiKey.rawValue)"
    
    enum EndPoints {
        case currentWeather(q: String)
        
        func getPath() -> String {
            switch self {
            case .currentWeather:
                return "weather"
            }
        }
        
        func getHTTPRequestMethod() -> String {
            return "GET"
        }
        
        func getHeaders(secretKey: String) -> [String: String] {

            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "X-Api-Key \(secretKey)",
                    "Host": "api.openweathermap.org"
            ]
        }
        
        func getParams() -> [String:String] {
            switch self {
            case .currentWeather(let city):
                return ["q": city,
                        "units": "imperial",
                        "appid": APIKeyPersonal.apiKey.rawValue
                        ]
            }
            
        }
        
        func paramsToString() -> String {
            let parameterArray = getParams().map{ key, value in
                return "\(key)=\(value)"
            }
            return parameterArray.joined(separator: "&")

        }
    }
    
    enum Result<T> {
        case success(T?)
        case failure(Error)
    }
    
    enum EndPointError: Error {
        case couldNotParse
        case noData
    }
    
    static private func makeRequest(for endPoint: EndPoints) -> URLRequest {
        let path = endPoint.getPath() // Get the first part of URL
        let stringParams = endPoint.paramsToString()
        let fullURL = URL(string: baseURL.appending("\(path)?\(stringParams)"))
//                print(fullURL)
        var request = URLRequest(url: fullURL!)
        request.httpMethod = endPoint.getHTTPRequestMethod()
        request.allHTTPHeaderFields = endPoint.getHeaders(secretKey: APIKEY)
//                print("\(String(describing: request.allHTTPHeaderFields))")
        return request
        
    }
    
    static func getWeatherData(cityName: String, _ completion: @escaping (Result<WeatherData>) -> Void)  {
        let weatheRequest = makeRequest(for: .currentWeather(q: cityName))
        
        let task = urlSession.dataTask(with: weatheRequest) { (data, response, error) in
            // If error
            if let error = error {
                return completion(Result.failure(error))
            }
            
            do {
                // Testing to see if got the proper json back
                let jsonObject = try JSONSerialization.jsonObject(with: data!, options: [])
                                    print(jsonObject)
                                    print("\n\n\n\n\n")
            } catch {
                print("about to print error")
                print(error.localizedDescription)
            }
            // If there's data
            guard let safeData = data else {
            
                return completion(Result.failure(EndPointError.noData))
                
            }
            // To decode data
            guard let result = try? JSONDecoder().decode(WeatherData.self, from: safeData) else {
                return completion(Result.failure(EndPointError.couldNotParse))
            }
            
            let cityName = result
            
            DispatchQueue.main.async {
                completion(Result.success(cityName))
            }
        }
        task.resume()
    }
    
    
}
