//
//  PickerViewData.swift
//  Setsy
//
//  Created by Saurabh on 30/05/22.
//

import Foundation

let confidentials = Confidentials()

struct EventManager {
    
    let geocodingBaseUrl = "https://api.openweathermap.org/geo/1.0/direct?appid=\(confidentials.geocoding_apiKey)"
    let eventBaseUrl = "https://api.sunrise-sunset.org/json?"
    
    let selectionOptions = ["Sunrise", "Sunset"]
    var selectedOption = ""
    
    func getEventTime(event: String, coordinateModel: CoordinatesModel) {
        
    }
    
    func getCoordinates(locationName: String) {
        let urlString = "\(geocodingBaseUrl)&q=\(locationName)"
        requestOpenWeather(urlString: urlString)
    }
    
    func requestOpenWeather(urlString: String) {
        if let openWeatherURL = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let coordinatesTask = session.dataTask(with: openWeatherURL) {(data, url, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeCoordinates = data {
                    if let coordinates = self.parseOpenWeatherJSON(coordinates: safeCoordinates) {
                        getEventTime(event: self.selectedOption, coordinateModel: coordinates)
                    }
                }
            }
            coordinatesTask.resume()
        }
    }
    
    func parseOpenWeatherJSON(coordinates: Data) -> CoordinatesModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([CoordinatesData].self, from: coordinates)
            let lat = decodedData[0].lat
            let lon = decodedData[0].lon
            let country = decodedData[0].country
            
            let coordinatesModel = CoordinatesModel(lat: lat, lon: lon, country: country)
            return coordinatesModel
        } catch {
            print(error)
            // we can have an error and return nil
            // that is why the return type has to be an optional
            return nil
        }
    }
}
