//
//  ContentView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 10..
//

import SwiftUI
import MapKit

struct ContentView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @EnvironmentObject var modelData: ModelData
    let location = ModelData.instance.locations.first!
    
    var body: some View {
        MapViewController(zoomValue: $modelData.zoomValue, circle: MKCircle(center: location.locationCoordinate, radius: 250), location: location)
            .environmentObject(modelData)
            .onAppear() {
                self.presentView()
            }
    }
    
    func presentView() {
        self.viewControllerHolder?.present(style: .overCurrentContext, animated: false) {
            GeofenceListView()
                .environmentObject(modelData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



