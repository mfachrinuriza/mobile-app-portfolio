//
//  FileReader.swift
//  mobile-app-portfolioTests
//
//  Created by Muhammad Fachri Nuriza on 18/02/24.
//

import Foundation
import core
import XCTest

final class FileReader {
    static func readJSON<T: Decodable>(file: String, type: T.Type) -> T? {
        let bundle = Bundle.main // Use Bundle.main to access the main bundle
        guard let url = bundle.url(forResource: file, withExtension: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
