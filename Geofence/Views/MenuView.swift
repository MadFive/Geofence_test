//
//  MenuView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        
        VStack {
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Title")
                    Text("desc")
                }
                Spacer()
                Button("Switch here") {
                    print("switched")
                }
            }
            
            HStack {
                HStack {
                    Image("alarm")
                    Text("Alarm")
                    Spacer()
                    Text("Drive in") //place holder
                }
                HStack {
                    Image("radius")
                    Text("Radius")
                    Spacer()
                    Text("2 km") //place holder
                }
            }
            
            
        }
        .padding([.leading, .trailing], 20)
        
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
