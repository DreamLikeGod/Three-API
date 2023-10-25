//
//  ApiManager.swift
//  apiNetworking
//
//  Created by Егор on 23.10.2023.
//

import Foundation
import CoreLocation

enum ApiType {
    
    case Fruits
    case Jokes
    case Login
    case Weather
    
    var baseUrl: String {
        switch self {
        case .Fruits:
            return "https://www.fruityvice.com/"
        case .Jokes:
            return "https://v2.jokeapi.dev/"
        case .Login:
            return "https://login.com/"
        case .Weather:
            return "https://api.open-meteo.com/"
        }
    }
    
    var headers: [String: String] {
        switch self {
        default: [:]
        }
    }
    
    var path: String {
        switch self {
        case .Fruits:
            return "api/fruit/"
        case .Jokes:
            return "joke/"
        case .Weather:
            return "v1/gfs?"
        default:
            return "LOGIN"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseUrl))!
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        switch self {
        case .Fruits:
            request.httpMethod = "GET"
        case .Jokes:
            request.httpMethod = "GET"
        case .Weather:
            request.httpMethod = "GET"
        default:
            request.httpMethod = "POST"
        }
        
        return request
    }
    
}

class ApiManager {
    
    public static let shared = ApiManager()
    
    private init() {}
    
    // MARK: - Fruits
    public func getAllFruits(completion: @escaping (Fruit) -> Void) {
        var request = ApiType.Fruits.request
        request.url = URL(string: "all", relativeTo: request.url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, 
                let fruits = try? JSONDecoder().decode(Fruit.self, from: data) {
                completion(fruits)
            } else {
                completion([])
                print(error!)
            }
        }
        task.resume()
    }
    public func getFruit(with id: Int? = nil, or name: String? = nil, completion: @escaping (FruitElement) -> Void) {
        var request = ApiType.Fruits.request
        if let id = id {
            request.url = URL(string: "\(id)", relativeTo: request.url)
        } else if let name = name {
            request.url = URL(string: name, relativeTo: request.url)
        } else {
            request.url = URL(string: "random", relativeTo: request.url)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let fruit = try? JSONDecoder().decode(FruitElement.self, from: data) {
                completion(fruit)
            } else {
                print(error!)
                fatalError()
            }
        }
        task.resume()
    }
    
    // MARK: - Jokes
    public func getJokes(amountOf jokes: Int? = nil, with themes: [JokesTheme]? = nil, and blackFlags: [JokesBlackFlags]? = nil, completion: @escaping (Jokes?) -> Void) {
        var request = ApiType.Jokes.request
        var addons = ""
        if let themes = themes {
            for theme in themes {
                addons.append(theme.rawValue)
                if theme != themes.last {
                    addons.append(",")
                }
            }
        } else {
            addons.append("Any")
        }
        if let blackFlags = blackFlags {
            addons.append("?blacklistFlags=")
            for blackFlag in blackFlags {
                addons.append(blackFlag.rawValue)
                if blackFlag != blackFlags.last {
                    addons.append(",")
                } else {
                    addons.append("&")
                }
            }
        } else {
            addons.append("?")
        }
        
        addons.append("type=twopart")
        
        if let amount = jokes {
            addons.append("&amount=\(amount)")
        }
        
        request.url = URL(string: addons, relativeTo: request.url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let _ = jokes {
                    if let arr = try? JSONDecoder().decode(JokeArr.self, from: data) {
                        completion(arr.jokes)
                    } else {
                        completion(nil)
                    }
                } else {
                    if let joke = try? JSONDecoder().decode(Joke.self, from: data) {
                        var arr = Jokes()
                        arr.append(joke)
                        completion(arr)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Weather
    public func getWeather(with coordinates: CLLocationCoordinate2D, completion: @escaping (Weather?) -> Void) {
        
        var dateString: String {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            return formatter.string(from: date)
        }
        var request = ApiType.Weather.request
        var addons = ""
        
        addons.append("latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)")
        addons.append("&hourly=temperature_2m,rain,visibility,windspeed_10m,winddirection_10m&windspeed_unit=ms")
        addons.append("&timeformat=unixtime&timezone=Europe%2FMoscow&start_date=\(dateString)&end_date=\(dateString)")
        
        addons = (request.url?.absoluteString)! + addons
        
        request.url = URL(string: addons)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let weather = try? JSONDecoder().decode(Weather.self, from: data) {
                    completion(weather)
                } else {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
