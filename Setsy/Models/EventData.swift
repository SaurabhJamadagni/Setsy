//
//  EventData.swift
//  Setsy
//
//  Created by Saurabh on 09/06/22.
//

import Foundation

struct EventData: Codable {
    let results: Results
}

struct Results: Codable {
    let sunrise: String
    let sunset: String
}
