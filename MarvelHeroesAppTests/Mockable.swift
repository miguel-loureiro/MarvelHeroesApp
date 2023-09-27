//
//  Mockable.swift
//  MarvelHeroesAppTests
//
//  Created by António Loureiro on 31/01/2023.
//

import Foundation

// MARK: snippet parts taken from:
//    https://www.youtube.com/watch?v=A627xU_94kE "Mocking a Network Request(Unit Testing Part 3)

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        if let path = bundle.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                return decodedObject
            } catch {
                fatalError("Failed to load JSON file")
            }
        } else {
            fatalError("Failed to load JSON file")
        }
    }
    
    func loadData(filename: String, ext: String = "json") -> Data {
        
        if let path = bundle.url(forResource: filename, withExtension: ext) {
            do {
                return try Data(contentsOf: path)
            } catch {
                fatalError("Failed to load file \(filename) with extension \(ext)")
            }
        } else {
            fatalError("Failed to load file \(filename) with extension \(ext)")
        }
    }
}
