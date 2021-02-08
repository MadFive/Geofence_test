//
//  MapView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
    
    
    
    @State private var region = MKCoordinateRegion()
    
    var location: Location
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
    
    var body: some View {
        Map(coordinateRegion: $region)
            .onAppear {
                setRegion(coordinate)
            }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(location: ModelData.instance.locations.first!)
    }
}
