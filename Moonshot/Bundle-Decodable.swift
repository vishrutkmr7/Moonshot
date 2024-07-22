//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Vishrut Jha on 7/22/24.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError(
                "failed to decode \(file) from bundle due to missing key \(key.stringValue) - context: \(context.debugDescription)"
            )
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError(
                "failed to decode \(file) from bundle due to type mismatch - context: \(context.debugDescription)"
            )
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError(
                "failed to decode \(file) from bundle due to missing \(type) value - context: \(context.debugDescription)"
            )
        } catch DecodingError.dataCorrupted(_) {
            fatalError("falied to decode \(file) from bundle due to data corruption. The JSON seems invalid")
        } catch {
            fatalError("failed to decode \(file) from bundle because of \(error.localizedDescription)")
        }
    }
}
