//
//  PokemonApiInfo.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation

class PokemonApiInfo: Codable{
    
    let name: String
    let url: String
    let imageURL: String
    let number: String
    
    init(name: String, url: String, imageURL: String, number: String) {
        self.name = name
        self.url = url
        self.imageURL = imageURL
        self.number = number
    }
}
