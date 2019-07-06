//
//  PokemonDetailViewModel.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation

class PokemonDetailViewModel{
    
    var event: (_ absModel: AbstractModel<PokemonModel>) -> Void = {_ in }
    var imageEvent: (_ absModel: AbstractModel<Data>) -> Void = {_ in }
    
    let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        print("PokemonViewModel init")
        self.repository = repository
    }
    
    
    func getPokemon(url: String){
        self.event(AbstractModel(isLoading: true, isSuccess: false, error: false, obj: nil))
        repository.getPokemon(url: url, onSuccess: { (response) in
            self.event(AbstractModel(isLoading: false, isSuccess: true, error: false, obj: response))
        }, onError: {
            self.event(AbstractModel(isLoading: false, isSuccess: false, error: true, obj: nil))
        })
    }
    
    
    func getPokemonImage(imageURL: String){
        self.imageEvent(AbstractModel(isLoading: true, isSuccess: false, error: false, obj: nil))
        repository.getPokemonImage(imageURL: imageURL, onSuccess: { (data) in
            self.imageEvent(AbstractModel(isLoading: false, isSuccess: true, error: false, obj: data))
        }, onError: {
            self.imageEvent(AbstractModel(isLoading: false, isSuccess: false, error: true, obj: nil))
        })
    }

    
}
