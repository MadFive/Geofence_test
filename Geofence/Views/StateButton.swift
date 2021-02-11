//
//  StateButton.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 09..
//

import SwiftUI

struct StateButton: View {
    @Binding var statusOn: Bool

    var body: some View {
        Text(statusOn ? "ON" : "OFF")
            .foregroundColor(statusOn ? Color.blue : Color.gray)
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        StateButton(statusOn: .constant(true))
    }
}
