//
//  PickerViewData.swift
//  Setsy
//
//  Created by Saurabh on 30/05/22.
//

import Foundation

let confidentials = Confidentials()

protocol EventManagerDelegate {
    func updateUI(eventModel: EventModel)
    func didFailWithError(error: Error)
}

struct EventManager {
    
    let geocodingBaseUrl = "https://api.openweathermap.org/geo/1.0/direct?appid=\(confidentials.geocoding_apiKey)&limit=1"
    let eventBaseUrl = "https://api.sunrise-sunset.org/json?"
    
    let selectionOptions = ["Sunrise", "Sunset"]
    
    var delegate: EventManagerDelegate?
    var selectedOption = "Sunrise"
    var location = ""
    
    func getCoordinates(locationName: String) {
        let requestURL = "\(geocodingBaseUrl)&q=\(locationName)"
        requestOpenWeather(urlString: requestURL)
    }
    
    func requestOpenWeather(urlString: String) {
        // create url
        if let url = URL(string: urlString) {
            // create session
            let session = URLSession(configuration: .default)
            
            // create task
            let coordinatesTask = session.dataTask(with: url) {(data, url, error) in
                if error != nil {
                    // did fail with error
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let coordinates = self.parseOpenWeatherJSON(coordinates: safeData) {
                        self.getEventTime(coordinates: coordinates)
                    }
                }
            }
            
            // resume task
            coordinatesTask.resume()
        }
    }
    
    func parseOpenWeatherJSON(coordinates: Data) -> [Double]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([CoordinatesData].self, from: coordinates)
            let lat = decodedData[0].lat
            let lon = decodedData[0].lon
            let coordinates = [lat, lon]
            
            return coordinates
        } catch {
            // did fail with error
            print(error)
            return nil
        }
    }
    
    func getEventTime(coordinates: [Double]) {
        let urlString = "\(eventBaseUrl)lat=\(coordinates[0])&lng=\(coordinates[1])"
        fetchEventTime(urlString: urlString)
    }
    
    func fetchEventTime(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let eventTask = session.dataTask(with: url, completionHandler: handle(data:url:error:))
            eventTask.resume()
        }
        
        
    }
    
    func handle(data: Data?, url: URLResponse?, error: Error?) {
        if error != nil {
            // did fail with error
            print(error!)
            return
        }
        
        if let safeData = data {
            if let eventTime = parseEventJSON(eventTimes: safeData) {
                // update UI
//                self.delegate?.updateUI(eventModel: eventTime)
                print(eventTime.eventImage)
                print(eventTime.eventName)
                print(eventTime.sunset)
                print(eventTime.sunrise)
            }
        }
    }
    
    func parseEventJSON(eventTimes: Data) -> EventModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(EventData.self, from: eventTimes)
            
            let eventName = selectedOption
            let sunrise = decodedData.results.sunrise
            let sunset = decodedData.results.sunset
            
            let eventModel = EventModel(eventName: eventName, sunrise: sunrise, sunset: sunset)
            
            return eventModel
        } catch {
            // did fail with error
            print(error)
            return nil
        }
    }
    
    
    
    
    
    
}
