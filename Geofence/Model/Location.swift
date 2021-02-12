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
    //var id = UUID()
    
    public var name: String
    public var address: String
    public var latitude: Double
    public var longitude: Double
    private var alarm: Int
    private var state: Int
    public var radius: Int
    
    public var alarmValue: Bool {
        get {
            return alarm == 0 ? false : true
        } set {
            alarm = newValue == false ? 0 : 1
        }
    }
    public var stateValue: Bool {
        get {
            return state == 0 ? false : true
        } set {
            state = newValue == false ? 0 : 1
        }
    }
    public var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
