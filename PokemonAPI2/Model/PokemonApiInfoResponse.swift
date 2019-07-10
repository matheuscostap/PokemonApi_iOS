//
//  PokemonApiInfoResponse.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation

class PokemonApiInfoResponse: Decodable{
    
    var results: [PokemonApiInfo] = []
    
    init(results: [PokemonApiInfo]) {
        self.results = results
    }
    
    enum CodingKeys: String, CodingKey{
        case results = "pokemon"
    }
}
