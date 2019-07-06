//
//  TypeViewModel.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation

class TypeViewModel{
    
    var event: (_ absModel: AbstractModel<TypeResponse>) -> Void = {_ in }
    
    let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    
    func getTypes(){
        self.event(AbstractModel(isLoading: true, isSuccess: false, error: true, obj: nil))
        repository.getTypes(onSuccess: { (response) in
            self.event(AbstractModel(isLoading: false, isSuccess: true, error: false, obj: response))
        }, onError: {
            self.event(AbstractModel(isLoading: false, isSuccess: false, error: true, obj: nil))
        })
    }
    
}
