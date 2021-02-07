//
//  LocationRoww.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct LocationRow: View {
    
    var location: Location
    
    var body: some View {
        Spacer()
        HStack {
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                Text(location.address)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text("ON") //location.alarm
                .foregroundColor(.blue)
        }
        Spacer()
    }
}

struct LocationRoww_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LocationRow(location: ModelData.instance.locations[0])
            LocationRow(location: ModelData.instance.locations[1])
        }
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
