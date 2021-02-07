//
//  Location.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import Foundation
import SwiftUI
import CoreLocation

struct Location: Hashable, Codable {
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var alarm: Int
    var state: Int
    var radius: Int
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
