//
//  MapView.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
        
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        
            Map(coordinateRegion: $region)
    }
    
    //add pin to exact location
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
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

    struct ContentView: View {
        
        //@State private var showEditView = false
        @Environment(\.presentationMode) private var presentationMode
        @Environment(\.viewController) private var viewControllerHolder: UIViewController?
        
        
        
        var body: some View {
            
            
//            ZStack {
//                MapView()
//                GeofenceListView()
//            }
            
            MapView()
                .onAppear() {
                    self.presentView()
                }
            
//            Button(action: {
//                //self.showEditView.toggle()
//                self.presentView()
//                //self.showModal = true
//            }) {
//                Text("SecondView")
//            }
//            .sheet(isPresented: self.$showEditView) {
//                GeofenceListView()
//            }
            
//            VStack {
//                List(0...20, id:\.self) { index in
//                    Text("Clicked on Row \(index+1)")
//                }
//                //Color.green
//            }.onTapGesture {
//                presentView()
//            }
        }
        
        func presentView() {
            
            self.viewControllerHolder?.present(style: .overCurrentContext, animated: false) {
                GeofenceListView()
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
