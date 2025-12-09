//
//  Secrets.swift
//  DogFinder
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import Foundation

struct Secrets {
    static var dogAPIkey: String {
        guard let key = Bundle.main.infoDictionary?["DOG_API_KEY"] as? String else {
            fatalError("Dog Finder API Key not found. Check Secrets.xcconfig")
        }
        return key
    }
}
