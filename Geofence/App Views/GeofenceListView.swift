//
//  ContentView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct GeofenceListView: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var showEditView = false
    @State private var selectedLocation: Location?
    
    var locationIndex: Int {
        if let location = selectedLocation {
            return modelData.locations.firstIndex(where: { $0.name == location.name })!
        }
        return 0
    }
    
    var body: some View {
        ZStack {
            VStack {
                //header
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width, height: 40)
                    Text("Geofence")
                }
                Divider()
                //        NavigationView {
                List(ModelData.instance.locations, id: \.name) { location in
                    ZStack {
                        LocationRow(location: location)
                            .onTapGesture {
                                self.selectedLocation = location
                                self.showEditView.toggle() // = true
                                //self.presentationMode.wrappedValue.dismiss()
                            }
                        //                    NavigationLink(destination: GeofenceEditView()) {
                        //                        EmptyView()
                        //                    }
                        //                    .buttonStyle(PlainButtonStyle())
                        //                    .opacity(0)
                        //                    .hidden()
                    }
                }
            }
            .background(Color.white)
            .environment(\.defaultMinListRowHeight, 80)
            .navigationBarTitle("Geofence", displayMode: .inline)
            .listRowBackground(Color.white)
            .offset(x: !self.showEditView ? 0 : -UIScreen.main.bounds.width)
            .animation(.spring())
            
            GeofenceEditView(show: $showEditView, location: $modelData.locations[locationIndex])
                .environmentObject(modelData)
                .offset(x: self.showEditView ? 0 : UIScreen.main.bounds.width)
                .animation(.spring())
                //.environmentObject(modelData)
            //        }
    }
    }
}

struct GeofenceListView_Previews: PreviewProvider {
    static var previews: some View {
        GeofenceListView()
            .environmentObject(ModelData.instance)
    }
}
