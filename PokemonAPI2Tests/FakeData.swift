//
//  FakeData.swift
//  PokemonAPI2Tests
//
//  Created by dbserver on 08/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation
@testable import PokemonAPI2
class FakeData{
 
    static let typesData = """
    {
    "results": [
    {
      "name": "normal",
      "url": "https://pokeapi.co/api/v2/type/1/"
    },
    {
      "name": "fighting",
      "url": "https://pokeapi.co/api/v2/type/2/"
    },
    {
      "name": "flying",
      "url": "https://pokeapi.co/api/v2/type/3/"
    },
    {
      "name": "poison",
      "url": "https://pokeapi.co/api/v2/type/4/"
    },
    {
      "name": "ground",
      "url": "https://pokeapi.co/api/v2/type/5/"
    },
    {
      "name": "rock",
      "url": "https://pokeapi.co/api/v2/type/6/"
    },
    {
      "name": "bug",
      "url": "https://pokeapi.co/api/v2/type/7/"
    },
    {
      "name": "ghost",
      "url": "https://pokeapi.co/api/v2/type/8/"
    },
    {
      "name": "steel",
      "url": "https://pokeapi.co/api/v2/type/9/"
    },
    {
      "name": "fire",
      "url": "https://pokeapi.co/api/v2/type/10/"
    },
    {
      "name": "water",
      "url": "https://pokeapi.co/api/v2/type/11/"
    },
    {
      "name": "grass",
      "url": "https://pokeapi.co/api/v2/type/12/"
    },
    {
      "name": "electric",
      "url": "https://pokeapi.co/api/v2/type/13/"
    },
    {
      "name": "psychic",
      "url": "https://pokeapi.co/api/v2/type/14/"
    },
    {
      "name": "ice",
      "url": "https://pokeapi.co/api/v2/type/15/"
    },
    {
      "name": "dragon",
      "url": "https://pokeapi.co/api/v2/type/16/"
    },
    {
      "name": "dark",
      "url": "https://pokeapi.co/api/v2/type/17/"
    },
    {
      "name": "fairy",
      "url": "https://pokeapi.co/api/v2/type/18/"
    },
    {
      "name": "unknown",
      "url": "https://pokeapi.co/api/v2/type/10001/"
    },
    {
      "name": "shadow",
      "url": "https://pokeapi.co/api/v2/type/10002/"
    }
    ]
    }
    """.data(using: .utf8)
    
    static let pokemonsByType = """
        
    {"pokemon": [
        {
          "pokemon": {
            "name": "pidgey",
            "url": "https://pokeapi.co/api/v2/pokemon/16/"
          },
          "slot": 1
        }
    ]}
    """.data(using: .utf8)
    
    static let pokemonDetail = """
        {
     
      "height": 3,
      "id": 16,
      "moves": [
        {
          "move": {
            "name": "razor-wind",
            "url": "https://pokeapi.co/api/v2/move/13/"
          },
          "version_group_details": [
            {
              "level_learned_at": 0,
              "move_learn_method": {
                "name": "machine",
                "url": "https://pokeapi.co/api/v2/move-learn-method/4/"
              },
              "version_group": {
                "name": "yellow",
                "url": "https://pokeapi.co/api/v2/version-group/2/"
              }
            },
            {
              "level_learned_at": 0,
              "move_learn_method": {
                "name": "machine",
                "url": "https://pokeapi.co/api/v2/move-learn-method/4/"
              },
              "version_group": {
                "name": "red-blue",
                "url": "https://pokeapi.co/api/v2/version-group/1/"
              }
            }
          ]
        }
    ],

      "types": [
        {
          "slot": 2,
          "type": {
            "name": "flying",
            "url": "https://pokeapi.co/api/v2/type/3/"
          }
        },
        {
          "slot": 1,
          "type": {
            "name": "normal",
            "url": "https://pokeapi.co/api/v2/type/1/"
          }
        }
      ],
      "weight": 18
    }
    """.data(using: .utf8)
    
}
