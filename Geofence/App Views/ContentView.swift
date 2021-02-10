//
//  ContentView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 10..
//

import SwiftUI
import MapKit


struct ContentView: View {
    
    //@State private var showEditView = false
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        let location = ModelData.instance.locations.first!
        MapViewController(circle: MKCircle(center: location.locationCoordinate, radius: 250), zoomValue: $modelData.zoomValue, location: location)
            .environmentObject(modelData)
            .onAppear() {
                self.presentView()
            }
    }
    
    func presentView() {
        
        self.viewControllerHolder?.present(style: .overCurrentContext, animated: false) {
            GeofenceListView()
                .environmentObject(modelData)
            
        }
        
        return
        
        let rootView = GeofenceListView() //Text("Hello World!")
        let controller = UIHostingController(rootView: rootView)
        controller.view.backgroundColor = .clear

        UIApplication.shared.windows.first?.rootViewController?.present(controller, animated: false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

extension UIViewController {
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, transitionStyle: UIModalTransitionStyle = .coverVertical, animated: Bool = true, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = UIColor.clear //init(red: 0, green: 0, blue: 0, alpha: 0)
        toPresent.rootView = AnyView(builder().environment(\.viewController, toPresent))
        self.present(toPresent, animated: animated, completion: nil)
    }
}
