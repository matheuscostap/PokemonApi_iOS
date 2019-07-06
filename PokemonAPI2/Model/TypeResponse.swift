//
//  TypeResponse.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation

class TypeResponse: Codable{
    
    var results: [TypeModel] = []
    
    enum CodingKeys: String, CodingKey{
        case results
    }
}
