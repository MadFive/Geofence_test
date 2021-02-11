//
//  ModelData.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import Foundation
import Combine
import SwiftUI
import MapKit

final class ModelData: ObservableObject {
    
    static let instance = ModelData()
    var shouldSaveChanges = false {
        willSet {
            self.saveChanges()
            objectWillChange.send()
        }
    }
    @Published var tempLocation: Location?
    @Published var zoomValue: Double = 0.1
    @Published var locations = [Location]()
    let filename = "locationData.json"
    let currentLocation = CLLocationCoordinate2D(latitude: 5.55613, longitude: 95.3218)
    private init() {
        locations = load("locationData.json")
    }
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        if let _data = loadDocumentsData(filename) {
            data = _data
        } else {
            data = loadBundleData(filename)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn’t parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    func loadBundleData(_ filename: String) -> Data {
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn’t find \(filename) in main bundle.")
        }
        
        do {
            let data = try Data(contentsOf: file)
            return data
        } catch {
            fatalError("Couldn’t load \(filename) from main bundle:\n\(error)")
        }
    }
    
    func loadDocumentsData(_ filename: String) -> Data? {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
    
    func saveDataToDocumentsDirectory(_ data: Data) {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        //let data = loadBundleData(filename)
        do {
            try data.write(to: url)
        } catch {
            fatalError("Couldn’t write \(filename) to documents directory:\n\(error)")
        }
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func saveChanges() {
        guard let location = self.tempLocation else { return }
        guard let index = locations.firstIndex(where: { $0.name == location.name }) else { return }
        locations[index] = location
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(locations)
            saveDataToDocumentsDirectory(data)
        } catch {
            fatalError("Couldn’t parse \(filename) as \(error)")
        }
    }
}



struct ModelDataKey: EnvironmentKey {
    static let defaultValue = ModelData.instance
}

extension EnvironmentValues {
    var modelData: ModelData {
        get {
            return self[ModelDataKey.self]
        }
        set {
            self[ModelDataKey.self] = newValue
        }
    }
}
