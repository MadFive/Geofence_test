//
//  RadiusButton.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 09..
//

import SwiftUI

struct RadiusButton: View {
    @Binding var location: Location
    
    var radiusValues = [1, 2, 3, 5, 10]
    @State var currentRadiusIndex = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .background(Color.clear)
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
        }
        .onTapGesture {
            //toggle
            currentRadiusIndex += 1
            let newIndex = currentRadiusIndex % radiusValues.count
            print(newIndex)
            location.radius = radiusValues[newIndex]
        }
    }
}

struct RadiusButton_Previews: PreviewProvider {
    static var previews: some View {
        RadiusButton(location: .constant(ModelData.instance.locations.first!))
    }
}
