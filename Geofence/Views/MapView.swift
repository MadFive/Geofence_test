//
//  MapView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import Foundation
import SwiftUI
import MapKit


struct MapViewController : UIViewControllerRepresentable {
    let mapViewDelegate = MapViewDelegate()
    var circle: MKCircle
    @Binding var zoomValue: Double
    var location: Location
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MapViewController>) -> UIHostingController<MapView> {
        return UIHostingController(rootView: MapView(zoomValue: $zoomValue, location: location))
    }

    func updateUIViewController(_ uiViewController: UIHostingController<MapView>, context: UIViewControllerRepresentableContext<MapViewController>) {

    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.delegate = mapViewDelegate                          // (1) This should be set in makeUIView, but it is getting reset to `nil`
        view.translatesAutoresizingMaskIntoConstraints = false   // (2) In the absence of this, we get constraints error on rotation; and again, it seems one should do this in makeUIView, but has to be here
        addCircle(to: view)
    }
}


struct MapView: View {
    
    
    @Environment(\.modelData) var observedEnvironment: ModelData
    //@EnvironmentObject var modelData: ModelData
    @State private var region = MKCoordinateRegion()
    @Binding var zoomValue: Double
    
    
    let mapViewDelegate = MapViewDelegate()
    var location: Location
    var circleSize: CGFloat {
        250 - 500 * CGFloat(zoomValue)
    }
    var circleColor: Color {
        location.alarmValue ? Color.green : Color.red
    }
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
    
    var body: some View {
        
        Map(coordinateRegion: $region)
//           overlay(CircleView(color: circleColor, size: circleSize))
            .onReceive(observedEnvironment.$zoomValue, perform: { _ in
                withAnimation {
                    self.setRegion(coordinate)
                    self.addOverlay()
                }
            })
            .onAppear {
                self.setRegion(coordinate)
            }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        let zoomValue = max($zoomValue.wrappedValue, 0.1) //$modelData.zoomValue.wrappedValue
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: zoomValue, longitudeDelta: zoomValue))
    }
    
    
    func addOverlay() {
        let circle = MKCircle(center: coordinate, radius: 250)
        
    }
    
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(zoomValue: .constant(0.2), location: ModelData.instance.locations.first!)
    }
}





private extension MapViewController {
    func addCircle(to view: MKMapView) {
        if !view.overlays.isEmpty {
            view.removeOverlays(view.overlays)
        }

        //guard let circle = circle else { return }
        let mapRect = circle.boundingMapRect
        view.setVisibleMapRect(mapRect, edgePadding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), animated: true)
        view.addOverlay(circle)
    }
}

class MapViewDelegate: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKCircleRenderer(overlay: overlay) //MKPolylineRenderer(overlay: overlay)
        renderer.fillColor = UIColor.red.withAlphaComponent(0.5)
        renderer.strokeColor = UIColor.red.withAlphaComponent(0.8)
        return renderer
    }
}



extension Map {
    func mapStyle(_ mapType: MKMapType, showScale: Bool = true, showTraffic: Bool = false) -> some View {
        let map = MKMapView.appearance()
        map.mapType = mapType
        map.showsScale = showScale
        map.showsTraffic = showTraffic
        return self
    }

    func addAnnotations(_ annotations: [MKAnnotation]) -> some View {
        MKMapView.appearance().addAnnotations(annotations)
        return self
    }
    
    func addOverlay(_ overlay: MKOverlay) -> some View {
        MKMapView.appearance().addOverlay(overlay)
        return self
    }
}
