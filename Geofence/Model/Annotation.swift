//
//  Annotation.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 12..
//

import SwiftUI
import MapKit

final class Annotation: NSObject, Identifiable, MKAnnotation {
    
    var id: String
    var location: Location
    let coordinate: CLLocationCoordinate2D
    //var radius: Double
    
    init(location: Location) {
        self.id = UUID().uuidString
        self.location = location
        self.coordinate = location.locationCoordinate
    }
    
}
