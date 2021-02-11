//
//  MenuView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI
import CoreLocation

struct MenuView: View {
    
//    @Binding private var statusOn: Bool
//    @Binding private var alarmOn: Bool
//    @Binding private var radiusValue: Int
//
    @Binding var location: Location
    var distance: Int {
        let location1 = CLLocation(latitude: location.locationCoordinate.latitude, longitude: location.locationCoordinate.longitude)
        let location2 = CLLocation(latitude: ModelData.instance.currentLocation.latitude, longitude: ModelData.instance.currentLocation.longitude)
        return Int(location1.distance(from: location2).rounded())
    }
    
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.title)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Text("\(distance)m") //CurrentPosition - 5.55613, 95.3218
                        Divider()
                        Text(location.address)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                Spacer()
                
                Toggle(isOn: $location.stateValue) { //$location.stateValue ??
                    Text("")
                }
                .frame(width: 30)
                .padding(.trailing, 20)
            }
            Divider()
            HStack {
                
                AlarmButton(location: $location)
                
                Divider()
                
                RadiusButton(location: $location)
            }
        }
        .padding([.leading, .trailing], 20)
        .padding([.top, .bottom], 30)
        //.background(Color.green)
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(location: .constant(ModelData.instance.locations.first!))
    }
}
