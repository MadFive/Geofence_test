//
//  View+Extensions.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorners(radius: radius, corners: corners))
    }
}
