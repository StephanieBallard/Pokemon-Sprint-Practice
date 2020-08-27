//
//  PokemonController.swift
//  PokemonSprintPractice
//
//  Created by Stephanie Ballard on 8/25/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

class PokemonController {
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    enum NetworkError: Error {
        case badUrl
        case noAuth
        case badAuth
        case otherError
        case badData
        case noDecode
        case badImage
        case failedFetch
    }
    
    var pokedex: [Pokemon] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    private lazy var jsonDecoder = JSONDecoder()
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    func fetchPokemon(searchTerm: String, completion: @escaping CompletionHandler) {
        let requestURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        print(requestURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to fetch pokemon with error: \(error)")
                completion(.failure(.failedFetch))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print(response)
                completion(.failure(.badAuth))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            do {
                let pokemon = try self.jsonDecoder.decode(Pokemon.self, from: data)
                print("Success fetching pokemon: \(pokemon)")
                completion(.success(true))
            } catch {
                print("Error decoding pokemon: \(error)")
                completion(.failure(.badData))
            }
        }.resume()
    }
    
    func savePokemon(pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
}
