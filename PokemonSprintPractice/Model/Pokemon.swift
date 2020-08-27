//
//  Pokemon.swift
//  PokemonSprintPractice
//
//  Created by Stephanie Ballard on 8/25/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation
// Steps for implementing Codable yourself (to flatten the JSON)
// - Pick the values you want out of the JSON and create constants or variables for them in your struct
// - Create enum(s) that are string raw values and adopt the CodingKey protocol to define the keys at which the values you want live.
// - Call init(from decoder: Decoder) throws
// - Create a container to represent the top level of JSON
// - Create nested containers as needed to pull the values you want out

struct Pokemon: Codable {
    let name: String
    let sprite: URL
    let id: Int
    let types: [String]
    let abilities: [String]

    enum PokemonKeys: String, CodingKey {
        case sprites
        case abilities
        case types
        case name
        case id

        enum SpritesKeys: String, CodingKey {
            case frontDefault = "front_default"
        }

        enum AbiltiesKeys: String, CodingKey {
            case ability
            
            enum AbilityKeys: String, CodingKey {
                case name
            }
        }

        enum TypesKeys: String, CodingKey {
            case type
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)

        let spriteContainer = try container.nestedContainer(keyedBy: PokemonKeys.SpritesKeys.self, forKey: .sprites)
        sprite = try spriteContainer.decode(URL.self, forKey: .frontDefault)

        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        // how to parse an array of dictionaries
        var abilities: [String] = []
        while !abilitiesContainer.isAtEnd {
            let abilityContainer = try abilitiesContainer.nestedContainer(keyedBy: PokemonKeys.AbiltiesKeys.self)
            let abilityNameContainer = try abilityContainer.nestedContainer(keyedBy: PokemonKeys.AbiltiesKeys.AbilityKeys.self, forKey: .ability)
            let name = try abilityNameContainer.decode(String.self, forKey: .name)
            abilities.append(name)
        }
        
        self.abilities = abilities

        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        types = try typesContainer.decode([String].self)
    }
}

//struct Pokemon: Codable {
//    let abilities: [Ability]
//    let id: Int
//    let name: String
//    let sprites: Sprites
//    let types: [TypeElement]
//}
//
//// MARK: - Ability
//struct Ability: Codable {
//    let ability: Species
//}
//
//// MARK: - Species
//struct Species: Codable {
//    let name: String
//}
//
//// MARK: - Sprites
//struct Sprites: Codable {
//    let front_default: String
//}
//
//// MARK: - TypeElement
//struct TypeElement: Codable {
//    let type: Species
//}
