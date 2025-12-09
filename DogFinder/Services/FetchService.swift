//
//  FetchService.swift
//  DogFinder
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badResponse
}

@MainActor
struct FetchService {
    
    private let baseURL = "https://api.thedogapi.com/v1/breeds"
    
    func fetchDog() async throws -> [Dog] {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Secrets.dogAPIkey, forHTTPHeaderField: "x-api-key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode([Dog].self, from: data)
    }
    
}
