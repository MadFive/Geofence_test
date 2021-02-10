//
//  ZoomView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI

struct ZoomView: View {
    
    @EnvironmentObject var modelData: ModelData
    //var zoomValue = 0.1
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
        
            VStack {
                Button(action: {
                    modelData.zoomValue -= (modelData.zoomValue < 0.2) ? 0 : 0.1
                    print(modelData.zoomValue)
                    
                }) { Text("+").font(.title) } //Image("ic_positive")
                Spacer()
                Divider()
                Spacer()
                Button(action: {
                    print(modelData.zoomValue)
                    modelData.zoomValue += 0.1
                    
                    
                }) { Text("-").font(.title) }
            }
            .padding([.top, .bottom], 10)
        }
        .shadow(radius: 10)
        .frame(width: 50, height: 100, alignment: .center)
    }
}

struct ZoomView_Previews: PreviewProvider {
    static var previews: some View {
        ZoomView()
    }
}
