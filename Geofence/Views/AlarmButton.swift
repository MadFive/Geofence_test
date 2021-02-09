//
//  alarmButton.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 09..
//

import SwiftUI

struct AlarmButton: View {
    @Binding var location: Location
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .background(Color.clear)
            
            HStack {
                Image("ic_alarm")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Alarm")
                Spacer()
                Text(location.alarmValue ? "Drive out" : "Drive in")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .onTapGesture {
            //toggle
            //location.alarmValue.toggle()
            location.alarmValue.toggle()
        }
    }
}

struct AlarmButton_Previews: PreviewProvider {
    static var previews: some View {
        AlarmButton(location: .constant(ModelData.instance.locations.first!))
    }
}
