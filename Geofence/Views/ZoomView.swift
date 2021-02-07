//
//  ZoomView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct ZoomView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
        
            VStack {
                Button("+") {
                    print("plus")
                }
                Button("-") {
                    print("minus")
                }
            }
        }
        .shadow(radius: 10)
        .frame(width: 25, height: 100, alignment: .center)
    }
}

struct ZoomView_Previews: PreviewProvider {
    static var previews: some View {
        ZoomView()
    }
}
