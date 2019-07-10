//
//  PokemonDetailViewModelTest.swift
//  PokemonAPI2Tests
//
//  Created by dbserver on 08/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import XCTest
@testable import PokemonAPI2
class PokemonDetailViewModelTest: XCTestCase {

    var detailsViewModel: PokemonDetailViewModel!
    var repository: PokemonRepository!
    var networkSuccess: NetworkHandler!
    var networkError: NetworkHandler!
    
    
    override func setUp() {
        self.networkSuccess = NetworkHandlerMock(data: FakeData.pokemonDetail!)
        self.networkError = NetworkHandlerMock(error: NSError(domain: "", code: 1, userInfo: nil))
    }

    override func tearDown() {
        self.networkError = nil
        self.networkSuccess = nil
        self.repository = nil
        self.detailsViewModel = nil
    }

    func testGetPokemonSuccess() {
        self.repository = PokemonRepository(networkSuccess)
        self.detailsViewModel = PokemonDetailViewModel(repository: repository)
        
        self.detailsViewModel.event = {(res) in
            if !res.isLoading{
                XCTAssert(res.isSuccess && res.obj != nil, "Retorno deveria ser sucesso e obj != nil")
            }
        }
        self.detailsViewModel.getPokemon(url: "www.teste.com")
    }
    
    func testGetPokemonError() {
        self.repository = PokemonRepository(networkError)
        self.detailsViewModel = PokemonDetailViewModel(repository: repository)
        
        self.detailsViewModel.event = {(res) in
            if !res.isLoading{
                XCTAssert(res.error && res.obj == nil, "Retorno deveria ser error e obj == nil")
            }
        }
        self.detailsViewModel.getPokemon(url: "www.teste.com")
    }
    
    /*func testGetPokemonImageSuccess(){
        self.repository = PokemonRepository(networkSuccess)
        self.detailsViewModel = PokemonDetailViewModel(repository: repository)
        
        self.detailsViewModel.event = {(res) in
            if !res.isLoading{
                XCTAssert(res.isSuccess && res.obj != nil, "Retorno deveria ser sucesso e obj != nil")
            }
        }
        self.detailsViewModel.getPokemonImage(imageURL: "www.teste.com")
    }
    
    func testGetPokemonImageError(){
        self.repository = PokemonRepository(networkError)
        self.detailsViewModel = PokemonDetailViewModel(repository: repository)
        
        self.detailsViewModel.event = {(res) in
            if !res.isLoading{
                XCTAssert(res.error && res.obj == nil, "Retorno deveria ser error e obj == nil")
            }
        }
        self.detailsViewModel.getPokemonImage(imageURL: "www.teste.com")
    }*/


}
