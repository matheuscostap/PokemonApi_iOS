//
//  PokemonModel.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation

class PokemonModel: Decodable{
    
    let height: Int
    let weight: Int
    let moves: [MoveModel]
    let types: [TypeModel]
    
    init(height: Int, weight: Int, moves: [MoveModel], types: [TypeModel]) {
        self.height = height
        self.weight = weight
        self.moves = moves
        self.types = types
    }
    
    enum CodingKeys: String, CodingKey{
        case height
        case weight
        case moves
        case types
    }
    
    required init(from decoder: Decoder) throws {
        let info = try decoder.container(keyedBy: CodingKeys.self)
        weight = try info.decode(Int.self, forKey: .weight)
        height = try info.decode(Int.self, forKey: .height)
        moves = try info.decode([MoveModel].self, forKey: .moves)
        types = try info.decode([TypeModel].self, forKey: .types)
    }
    
}
