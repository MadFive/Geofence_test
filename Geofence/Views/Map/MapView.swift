//
//  MapView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.modelData) var observedEnvironment: ModelData
    @EnvironmentObject var modelData: ModelData
    @State private var region = MKCoordinateRegion()
    @Binding var zoomValue: Double
    @State var coll = [MKPointAnnotation]()
    
    let mapViewDelegate = MapViewDelegate()
    //var location: Location
    var circleSize: CGFloat {
        CGFloat((modelData.tempLocation?.radius ?? 1) * 25)
        
    }
    var circleColor: Color {
        modelData.tempLocation?.alarmValue ?? false ?  Color.red : Color.green
    }
    var coordinate: CLLocationCoordinate2D {
        //return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        return CLLocationCoordinate2D(latitude: 53.2734, longitude: -7.77832031)
    }
    
    func addCircle() {
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = coordinate
        //            destinationAnnotation.title = "Location"
        coll.append(destinationAnnotation)
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: coll) { item in
            MapAnnotation(coordinate: coordinate, content: {
                CircleView(color: circleColor, size: circleSize)
            })
        }
        .onReceive(observedEnvironment.$zoomValue, perform: { _ in
            withAnimation {
                self.setRegion(coordinate)
            }
        })
        .onAppear {
            self.setRegion(coordinate)
            self.addCircle()
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        let zoomValue = max($zoomValue.wrappedValue, 0.1) //$modelData.zoomValue.wrappedValue
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: zoomValue, longitudeDelta: zoomValue))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(zoomValue: .constant(0.2))
    }
}





