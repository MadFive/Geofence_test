//
//  GeofenceEditView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct GeofenceEditView: View {
    
    @Binding var show: Bool
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        
        VStack {
            //header
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width, height: 40)
                
                    HStack {
                        Button(action: { self.show = false }) { Text("Back") }
                        Spacer()
                        Text("Edit Geofence")
                        Spacer()
                        Button(action: { self.show = false }) { Text("Save") }
                    }
                .padding([.leading, .trailing], 20)
            }
            
            
            Spacer()
            //ZoomView()
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width, height: 100)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                MenuView()
            }
        }
        
        //            .navigationBarTitle("Edit Geofence", displayMode: .inline)
        //            .navigationBarBackButtonHidden(true)
        //            .navigationBarItems(
        //                leading: Button(action: { presentation.wrappedValue.dismiss() }) {
        //                  Image(systemName: "chevron.left")
        //                    .imageScale(.large)
        //                },
        //                trailing: Button("Save") {
        //                    self.save()
        //                })
        .foregroundColor(.black)
        .background(Color.clear)
    }
    
    func save() {
        self.show = false
        return
        //save state and return to list
        //fancy popup message about saving it succesfully upon completion
        
        
        //data permanance??? - copy json to device storage upon first run
        let model = ModelData.instance
        let data = model.loadBundleData(model.filename)
        ModelData.instance.saveDataToDocumentsDirectory(data)
        
        
    }
    
    
}

//struct GeofenceEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        GeofenceEditView(show: true)
//    }
//}
