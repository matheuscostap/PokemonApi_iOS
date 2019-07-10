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
    
    private let urlSession: NetworkHandler!
    
    init(_ urlSession: NetworkHandler) {
        self.urlSession = urlSession
    }
    
    
    func getTypes(onSuccess: @escaping (_ result: TypeResponse) -> Void, onError: @escaping () -> Void) {
        self.urlSession.request(url: TYPE_URL!) { (data, response, error) in
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
    }
    
    
    func getPokemonByType(url: String, onSuccess: @escaping (_ result: PokemonApiInfoResponse) -> Void, onError: @escaping () -> Void){
        let urlType = URL(string: url)
        
        self.urlSession.request(url: urlType!) { (data, response, error) in
            guard let data = data else{
                onError()
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let res = try decoder.decode(PokemonApiInfoResponse.self, from: data)
                onSuccess(res)
                
            }catch let error{
                print("Erro: \(error)")
                onError()
            }
        }
    }
    
    
    func getPokemonImage(imageURL: String, onSuccess: @escaping (_ data: Data) -> Void, onError: @escaping () -> Void){
        let urlType = URL(string: imageURL)
        self.urlSession.request(url: urlType!) { (data, response, error) in
            guard let data = data else{
                onError()
                return
            }
            
            onSuccess(data)
        }
    }
    
    
    func getPokemon(url: String, onSuccess: @escaping (_ result: PokemonModel) -> Void, onError: @escaping () -> Void){
        let urlType = URL(string: url)
        self.urlSession.request(url: urlType!) { (data, response, error) in
            guard let data = data else{
                onError()
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let res = try decoder.decode(PokemonModel.self, from: data)
                onSuccess(res)
                
            }catch let error{
                print("Erro: \(error)")
                onError()
            }
        }
    }
    
}


extension URLSession: NetworkHandler{
    func request(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
}
