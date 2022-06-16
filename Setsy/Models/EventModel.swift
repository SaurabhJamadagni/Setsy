//
//  EventModel.swift
//  Setsy
//
//  Created by Saurabh on 10/06/22.
//

import Foundation

struct EventModel {
    let eventName: String
    let sunrise: String
    let sunset: String
    
    var eventImage: String {
        switch eventName {
        case "Sunrise":
            return "sunrise.fill"
        case "Sunset":
            return "sunset.fill"
        default:
            return "sunrise.fill"
        }
    }
}
