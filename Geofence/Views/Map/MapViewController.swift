//
//  MapViewController.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 11..
//

import SwiftUI
import MapKit


struct MapViewController : UIViewControllerRepresentable {
    @Binding var zoomValue: Double
    let mapViewDelegate = MapViewDelegate()
    var circle: MKCircle
    var location: Location
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MapViewController>) -> UIHostingController<MapView> {
        return UIHostingController(rootView: MapView(zoomValue: $zoomValue))
    }

    func updateUIViewController(_ uiViewController: UIHostingController<MapView>, context: UIViewControllerRepresentableContext<MapViewController>) {

    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.delegate = mapViewDelegate as MKMapViewDelegate                          // (1) This should be set in makeUIView, but it is getting reset to `nil`
        view.translatesAutoresizingMaskIntoConstraints = false   // (2) In the absence of this, we get constraints error on rotation; and again, it seems one should do this in makeUIView, but has to be here
        addCircle(to: view)
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

