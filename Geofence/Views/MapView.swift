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
    
    @Environment(\.modelData) var observedEnvironment: ModelData
    //@EnvironmentObject var modelData: ModelData
    @State private var region = MKCoordinateRegion()
    @Binding var zoomValue: Double
    
    var location: Location
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
    
    var body: some View {
        Map(coordinateRegion: $region)
            .onReceive(observedEnvironment.$zoomValue, perform: { _ in
                withAnimation { 
                    self.setRegion(coordinate)
                }
            })
            .onAppear {
                self.setRegion(coordinate)
            }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        let zoomValue = max($zoomValue.wrappedValue, 0.1) //$modelData.zoomValue.wrappedValue
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: zoomValue, longitudeDelta: zoomValue))
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(zoomValue: .constant(0.2), location: ModelData.instance.locations.first!)
    }
}
