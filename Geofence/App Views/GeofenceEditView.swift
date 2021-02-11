//
//  GeofenceEditView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct GeofenceEditView: View {
    
    @Environment(\.presentationMode) var presentation
    //@EnvironmentObject var modelData: ModelData
    @Binding var show: Bool
    //@Binding var location: Location
    @EnvironmentObject var modelData: ModelData
    
//    @State private var tempLocation: Location = ModelData.instance.locations.first!
//    var locationIndex: Int {
////        if let location = location {
//            return modelData.locations.firstIndex(where: { $0.name == location.name })!
////        }
////        return 0
//    }
    
    var body: some View {
        VStack(alignment: .leading) {
            //let offset = 50
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width, height: 40)
                
                    HStack {
                        Button(action: { self.show = false }) { Text("Back") }
                        Spacer()
                        Text("Edit Geofence")
                        Spacer()
                        Button(action: { self.save(); self.show = false }) { Text("Save") }
                    }
                .padding([.leading, .trailing], 20)
            }
            
            Spacer()
            
            ZoomView()
                .offset(y: -50)
                .padding(.leading, 20)
                .environmentObject(modelData)
            
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                if modelData.tempLocation != nil {
                    MenuView(location: Binding($modelData.tempLocation)!)
                }
                
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
//        if let tempLocation = tempLocation {
//            location = tempLocation
        //modelData.locations[locationIndex] = location
//        }
        print(modelData.shouldSaveChanges)
        modelData.shouldSaveChanges.toggle()
        
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
        GeofenceEditView(show: .constant(true))
//                        .previewDevice(PreviewDevice(rawValue: deviceName))
//                        .previewDisplayName(deviceName)
//        }
        
    }
}
