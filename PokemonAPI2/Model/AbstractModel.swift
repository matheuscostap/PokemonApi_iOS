//
//  AbstractModel.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import Foundation

class AbstractModel<T>{
    var isLoading: Bool = false
    var isSuccess: Bool = false
    var error: Bool = false
    var obj: T?
    
    init(isLoading: Bool, isSuccess: Bool, error: Bool, obj: T?) {
        self.isLoading = isLoading
        self.isSuccess = isSuccess
        self.error = error
        self.obj = obj
    }
}
