//
//  PokemonRepository.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation

class PokemonRepository{
    
    private let TYPE_URL = URL(string: "https://pokeapi.co/api/v2/type/")
    private let IMAGE_URL_BASE = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    
    static let instance = PokemonRepository()
    
    private init(){}
    
    
    func getTypes(onSuccess: @escaping (_ result: TypeResponse) -> Void, onError: @escaping () -> Void) {
        let task = URLSession.shared.dataTask(with: TYPE_URL!) { (data, response, error) in
            guard let data = data else{
                onError()
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let res = try decoder.decode(TypeResponse.self, from: data)
                onSuccess(res)
            }catch let error{
                print("Erro: \(error)")
                onError()
            }
        }
        
        task.resume()
    }
    
    
    func getPokemonByType(url: String, onSuccess: @escaping (_ result: PokemonApiInfoResponse) -> Void, onError: @escaping () -> Void){
        let urlType = URL(string: url)
        
        var pokeArray: [PokemonApiInfo] = []
        
        let task = URLSession.shared.dataTask(with: urlType!) { (data, response, error) in
            guard let data = data else{
                onError()
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let dict = json as? [String: Any]{
                    let pokemons = dict["pokemon"] as? [[String: Any]]
                    if let pokemons = pokemons{
                        pokemons.forEach({ (pokemon) in
                            let pokemonObj = pokemon["pokemon"] as? [String: Any]
                            if let pokemonObj = pokemonObj{
                                let url = pokemonObj["url"] as! String
                                let number = self.getPokemonNumber(pokemonUrl: url)
                                let imageURL = "\(self.IMAGE_URL_BASE)\(number).png"
                                let name = pokemonObj["name"] as! String
                                
                                let pokemonApiInfo = PokemonApiInfo(name: name, url: url, imageURL: imageURL, number: number)
                                pokeArray.append(pokemonApiInfo)
                            }
                        })
                        
                        onSuccess(PokemonApiInfoResponse(results: pokeArray))
                    }
                }
                
            }catch let error{
                print("Erro: \(error)")
                onError()
            }
        }
        
        task.resume()
    }
    
    
    func getPokemonImage(imageURL: String, onSuccess: @escaping (_ data: Data) -> Void, onError: @escaping () -> Void){
        let urlType = URL(string: imageURL)
        let task = URLSession.shared.dataTask(with: urlType!) { (data, response, error) in
            guard let data = data else{
                onError()
                return
            }
            
            onSuccess(data)
        }
        
        task.resume()
    }
    
    
    func getPokemon(url: String, onSuccess: @escaping (_ result: PokemonModel) -> Void, onError: @escaping () -> Void){
        let urlType = URL(string: url)
        let task = URLSession.shared.dataTask(with: urlType!) { (data, response, error) in
            guard let data = data else{
                onError()
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let dict = json as? [String: Any]{
                    let height = dict["height"] as! Int
                    let weight = dict["weight"] as! Int
                    var typeArray: [TypeModel] = []
                    var movesArray: [MoveModel] = []
                        
                    let moves = dict["moves"] as? [[String: Any]]
                    if let moves = moves{
                        moves.forEach{(moveDic) in
                            let move = moveDic["move"] as? [String: Any]
                            if let move = move{
                                let name = move["name"] as! String
                                let url = move["url"] as! String
                                movesArray.append(MoveModel(name: name.capitalized, url: url))
                            }
                        }
                    }
                    
                    let types = dict["types"] as? [[String: Any]]
                    if let types = types{
                        types.forEach{(typeDic) in
                            let type = typeDic["type"] as? [String: Any]
                            if let type = type{
                                let name = type["name"] as! String
                                let url = type["url"] as! String
                                typeArray.append(TypeModel(name: name, url: url))
                            }
                        }
                    }
                    
                    onSuccess(PokemonModel(name: "", height: height, weight: weight, moves: movesArray, types: typeArray))
                }
                
            }catch let error{
                print("Erro: \(error)")
                onError()
            }
        }
        
        task.resume()
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
