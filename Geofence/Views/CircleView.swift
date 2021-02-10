//
//  CircleView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 10..
//

import SwiftUI

struct CircleView: View {
    
    var color: Color
    var size: CGFloat
    
    var body: some View {
        Circle()
            .strokeBorder(color.opacity(0.8), lineWidth: 4)
            .background(Circle().foregroundColor(color.opacity(0.2)))
            .frame(width: size, height: size, alignment: .center)
            .animation(.default)
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(color: Color.red, size: 250)
    }
}
