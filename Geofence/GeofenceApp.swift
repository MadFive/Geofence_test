//
//  GeofenceApp.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

@main
struct GeofenceApp: App {
    @StateObject private var modelData = ModelData.instance
    
    var body: some Scene {
        WindowGroup {
//            MapView(zoomValue: $modelData.zoomValue, location: modelData.locations.first!)
            
            ContentView()
                .environmentObject(modelData)
        }
    }
}
