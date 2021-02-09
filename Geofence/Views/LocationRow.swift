//
//  LocationRoww.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct LocationRow: View {
    @EnvironmentObject var modelData: ModelData
    var location: Location
    var locationIndex: Int {
            modelData.locations.firstIndex(where: { $0.name == location.name })!
        }
    
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
            StateButton(statusOn: $modelData.locations[locationIndex].stateValue)
        }
        Spacer()
    }
}

struct LocationRoww_Previews: PreviewProvider {
    
    static var locations = ModelData.instance.locations
    static var previews: some View {
        Group {
            LocationRow(location: locations[0])
            LocationRow(location: locations[1])
        }
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
