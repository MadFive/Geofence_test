//
//  GeofenceEditView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct GeofenceEditView: View {
    @Environment(\.presentationMode) var presentation
    @Binding var show: Bool
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack(alignment: .leading) {
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
                        Button(action: { self.save(); self.show = false }) { Text("Save") }
                    }
                .padding([.leading, .trailing], 20)
            }
            Spacer()
            
            ZoomView()
                .offset(y: -50)
                .padding(.leading, 20)
                .environmentObject(modelData)
            
            //menu view
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                if modelData.tempLocation != nil {
                    MenuView(location: Binding($modelData.tempLocation)!)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 120)
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
        modelData.shouldSaveChanges.toggle()
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
