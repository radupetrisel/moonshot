//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Radu Petrisel on 11.07.2023.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let fileUrl = self.url(forResource: file, withExtension: nil) else {
            fatalError("Cannot locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: fileUrl) else {
            fatalError("Cannot load \(file) from bundle.")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        guard let astronauts = try? jsonDecoder.decode(T.self, from: data) else {
            fatalError("Cannot decode \(file) from bundle.")
        }
        
        return astronauts
    }
}
