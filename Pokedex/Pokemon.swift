//
//  Pokemon.swift
//  Pokedex
//
//  Created by Eileen Huang on 1/13/20.
//  Copyright © 2020 Eileen Huang. All rights reserved.
//

import Foundation

struct Pokemon: Codable {    // make it Codable to change from object to JSON or JSON -> object
    let name: String
    let url: String
}

struct PokemonList: Codable {   // list of pokemon from api
    let results: [Pokemon]
}

// data in struct is the key that you want to extract from JSON

struct PokemonData: Codable {     // store data from api call only storing id and type
    let id: Int
    let types: [PokemonTypeEntry]
}

struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
    let url: String
}

//"types": [         PokemonData
//  {
//    "slot": 2,     PokemonTypeEntry
//    "type": {      ^
//      "name": "poison",   PokemonType
//      "url": "https://pokeapi.co/api/v2/type/4/"
//    }
//  },
//  {
//    "slot": 1,
//    "type": {
//      "name": "grass",
//      "url": "https://pokeapi.co/api/v2/type/12/"
//    }
//  }
//],
