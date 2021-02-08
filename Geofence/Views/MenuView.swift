//
//  MenuView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct MenuView: View {
    
    @State private var alarmOn = false
    
    var location: Location
    
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.title)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Text("123m")
                        Divider()
                        Text(location.address)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                Spacer()
                Toggle(isOn: $alarmOn) {
                    Text("")
                }
            }
            Divider()
            HStack {
                HStack {
                    Image("ic_alarm")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Alarm")
                    Spacer()
                    Text((location.alarm == 0) ? "Drive out" : "Drive in")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        
                }
                .onTapGesture {
                    //toggle
                }
                
                Divider()
                
                HStack {
                    Image("ic_radius")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Radius")
                    Spacer()
                    Text("\(location.radius)km")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .onTapGesture {
                    //toggle
                }
            }
        }
        .padding([.leading, .trailing], 20)
        .padding([.top, .bottom], 30)
        //.background(Color.green)
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(location: ModelData.instance.locations.first!)
    }
}
