//
//  ContentView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct GeofenceListView: View {
    
    //@EnvironmentObject var modelData: TestModelData
    
    var body: some View {
        NavigationView {
            
            List(ModelData.instance.locations, id: \.name) { location in
                
            ZStack {
            LocationRow(location: location)
                NavigationLink(destination: GeofenceEditView(location: location)) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            .opacity(0)
            .hidden()
            }
                
        }
        .environment(\.defaultMinListRowHeight, 80)
        .navigationBarTitle("Geofence", displayMode: .inline)
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GeofenceListView()
    }
}
