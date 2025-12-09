//
//  SampleDogDetailView.swift
//  DogFinder
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import SwiftUI

extension DogViewModel {
    static let sampleDogDetailView = DogViewModel(dog: Dog(
        id: 1, name: "Affenpinscher",
        bredFor: "Small rodent hunting, lapdog",
        lifeSpan: "10 - 12 years",
        temperament: "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving",
        origin: "Germany, France",
        image: Dog.Image(url: "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg")
    ))
}
