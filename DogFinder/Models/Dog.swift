//
//  Dog.swift
//  DogFinder
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import Foundation

struct Dog: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let bredFor: String?
    let lifeSpan: String
    let temperament: String?
    let origin: String?
    let image: Image?
    
    struct Image: Decodable, Hashable {
        let url: String?
    }
}
