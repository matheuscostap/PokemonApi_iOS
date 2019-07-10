//
//  PokemonApiInfo.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation

class PokemonApiInfo: Decodable{
    private let IMAGE_URL_BASE = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    
    var name: String
    var url: String
    var imageURL: String = ""
    var number: String = ""
    
    
    required init(from decoder: Decoder) throws {
        print("---- INIT ----")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resp = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .pokemon)
        
        self.name = try resp.decode(String.self, forKey: .name)
        self.url = try resp.decode(String.self, forKey: .url)
        
        self.number = getPokemonNumber(pokemonUrl: url)
        self.imageURL = "\(self.IMAGE_URL_BASE)\(self.number).png"
    }
    
    enum CodingKeys: CodingKey{
        case pokemon
        case name
        case url
    }
    
    
    private func getPokemonNumber(pokemonUrl: String) -> String{
        return regexp(regexp: "\\/(\\d+)\\/", string: pokemonUrl)
    }
    
    
    private func regexp(regexp: String, string: String) -> String{
        do{
            let regex = try NSRegularExpression(pattern: regexp, options: [])
            let results = regex.matches(in: string, options: [], range: NSRange(string.startIndex..., in: string))
            let stringRes = results.map {
                String(string[Range($0.range, in: string)!])
            }
            
            var s = stringRes[0]
            s.removeFirst(1)
            s.removeLast(1)
            return s
        }catch let error{
            print("REGEXP ERRO: \(error)")
            return ""
        }
    }
}
