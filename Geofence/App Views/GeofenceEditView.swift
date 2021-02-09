//
//  GeofenceEditView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct GeofenceEditView: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var modelData: ModelData
    
    var location: Location
    var locationIndex: Int {
            modelData.locations.firstIndex(where: { $0.name == location.name })!
        }
//    var radiusValues = [1, 2, 3, 5, 10]
//    var currentRadiusIndex: Int {
//        return 1
//    }
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //let offset = 50
            MapView(location: location)
                .offset(y: 150)
                .padding(.top, -150)
            
            Spacer()
            
            ZoomView()
                .offset(y: -50)
                .padding(.leading, 20)
            
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                MenuView(location: $modelData.locations[locationIndex])
            }
            .frame(width: UIScreen.main.bounds.width, height: 120)
            //.background(Color.blue)
        }
        
            
            .navigationBarTitle("Edit Geofence", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: { presentation.wrappedValue.dismiss() }) {
                  Image(systemName: "chevron.left").imageScale(.large) },
                trailing: Button("Save") { self.save() })
            .foregroundColor(.black)
    }
    
    func save() {
        
        //commit changes to env obj
        modelData.locations[locationIndex] = location
        
        return
        //save state and return to list
        //fancy popup message about saving it succesfully upon completion
        
        
        //data permanance??? - copy json to device storage upon first run
        let data = modelData.loadBundleData(modelData.filename)
        modelData.saveDataToDocumentsDirectory(data)
        
        
    }
    
    
}

struct GeofenceEditView_Previews: PreviewProvider {
    static var previews: some View {
        
//        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
        GeofenceEditView(location: ModelData.instance.locations.first!)
//                        .previewDevice(PreviewDevice(rawValue: deviceName))
//                        .previewDisplayName(deviceName)
//        }
        
    }
}
