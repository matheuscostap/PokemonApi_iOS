//
//  MoveModel.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation

class MoveModel: Decodable{
    
    let name: String
    let url: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resp = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .move)
        
        self.name = try resp.decode(String.self, forKey: .name).capitalized
        self.url = try resp.decode(String.self, forKey: .url)
    }
    
    enum CodingKeys: CodingKey{
        case move
        case name
        case url
    }
}
