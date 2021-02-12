//
//  MapViewController.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 11..
//

import SwiftUI
import MapKit

struct MapViewController : UIViewRepresentable {
    @EnvironmentObject var modelData: ModelData
    let mapViewDelegate = MapViewDelegate()
    
    func makeUIView(context: Context) -> MKMapView {
        let location = modelData.tempLocation ?? modelData.locations.first!
        //modelData.currentRadius = Double(location.radius)
        let map = MKMapView()
        map.region = MKCoordinateRegion()
        return map
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        guard let location = modelData.tempLocation else { return }
        view.delegate = mapViewDelegate as MKMapViewDelegate
        let zoomValue = max(modelData.zoomValue, 0.02)
        let span = MKCoordinateSpan(latitudeDelta: zoomValue, longitudeDelta: zoomValue)
        let newRegion = view.regionThatFits(MKCoordinateRegion(center: location.locationCoordinate, span: span))
        view.setRegion(newRegion, animated: true)
        addCircle(to: view)
    }
    
    func addCircle(to view: MKMapView) {
        if !view.overlays.isEmpty {
            view.removeOverlays(view.overlays)
        }
        guard let location = modelData.tempLocation else { return }
        
        ///uncomment this row to only show the circle when the location status is enabled
//        guard location.stateValue else { return }
        let circle = MKCircle(center: location.locationCoordinate, radius: CLLocationDistance(location.radius * 1000))
        
        ///zoom map to fit the circle
//            let mapRect = circle.boundingMapRect
//            view.setVisibleMapRect(mapRect, edgePadding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), animated: true)
        
        view.addOverlay(circle)
    }
}

class MapViewDelegate: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKCircleRenderer(overlay: overlay) //MKPolylineRenderer(overlay: overlay)
        let color = (ModelData.instance.tempLocation?.alarmValue ?? false) ? UIColor.red : UIColor.green
        renderer.fillColor = color.withAlphaComponent(0.2)
        renderer.strokeColor = color.withAlphaComponent(0.5)
        return renderer
    }
}
