//
//  ModelData.swift
//  Geofence
//
//  Created by MadFive on 2021. 02. 07..
//

import Foundation
import Combine

//final class TestModelData: ObservableObject {
//    @Published var locations: [Location] = ModelData.instance.load(ModelData.instance.filename)
//}

struct ModelData {
    
    static let instance = ModelData()
    var locations = [Location]()
    let filename = "locationData.json"
    
    
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
}
