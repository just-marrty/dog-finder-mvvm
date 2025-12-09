//
//  DogListViewModel.swift
//  DogFinder
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import Foundation
import Observation

@Observable
@MainActor
class DogListViewModel {
    var dogs: [DogViewModel] = []
    var isLoading = false
    var errorMessage: String?
    
    let fetchService: FetchService
    
    init(fetchService: FetchService) {
        self.fetchService = fetchService
    }
    
    func loadDog() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let dogs = try await fetchService.fetchDog()
            self.dogs = dogs.map(DogViewModel.init)
        } catch {
            errorMessage = "Cannot load the data: \(error)"
        }
        isLoading = false
    }
    
    func search(for searchTherm: String) -> [DogViewModel] {
        if searchTherm.isEmpty {
            return dogs
        } else {
            return dogs.filter { dog in
                dog.name.localizedCaseInsensitiveContains(searchTherm)
            }
        }
    }
}

struct DogViewModel: Identifiable, Hashable {
    
    private var dog: Dog
    
    init(dog: Dog) {
        self.dog = dog
    }
    
    var id: Int {
        dog.id
    }
    
    var name: String {
        dog.name
    }
    
    var bredFor: String {
        dog.bredFor ?? "N/A"
    }
    
    var lifeSpan: String {
        dog.lifeSpan
    }
    
    var temperament: String {
        dog.temperament ?? "N/A"
    }
    
    var origin: String {
        let trimmed = (dog.origin ?? "").trimmingCharacters(in: .whitespaces)
        return trimmed.isEmpty ? "N/A" : trimmed
    }
    
    var urlImage: URL? {
        guard let urlString = dog.image?.url else { return nil }
        return URL(string: urlString)
    }
}

