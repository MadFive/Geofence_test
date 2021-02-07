//
//  GeofenceEditView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct GeofenceEditView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        
        
        VStack {
            MapView()
                .offset(y: 100)
                .padding(.top, -100)
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width, height: 100)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                MenuView()
            }
        }
        
            
            .navigationBarTitle("Edit Geofence", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: { presentation.wrappedValue.dismiss() }) {
                  Image(systemName: "chevron.left")
                    .imageScale(.large)
                },
                trailing: Button("Save") {
                    self.save()
                })
            .foregroundColor(.black)
    }
    
    func save() {
        
        return
        //save state and return to list
        //fancy popup message about saving it succesfully upon completion
        
        
        //data permanance??? - copy json to device storage upon first run
        let model = ModelData.instance
        let data = model.loadBundleData(model.filename)
        ModelData.instance.saveDataToDocumentsDirectory(data)
        
        
    }
    
    
}

struct GeofenceEditView_Previews: PreviewProvider {
    static var previews: some View {
        GeofenceEditView()
    }
}
