//
//  PokemonListViewModelTest.swift
//  PokemonAPI2Tests
//
//  Created by dbserver on 08/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import XCTest
@testable import PokemonAPI2
class PokemonListViewModelTest: XCTestCase {

    var pokelistViewModel: PokemonListViewModel!
    var repository: PokemonRepository!
    var networkSuccess: NetworkHandler!
    var networkError: NetworkHandler!
    
    
    override func setUp() {
        self.networkSuccess = NetworkHandlerMock(data: FakeData.pokemonsByType!)
        self.networkError = NetworkHandlerMock(error: NSError(domain: "", code: 1, userInfo: nil))
    }

    override func tearDown() {
        self.networkError = nil
        self.networkSuccess = nil
        self.repository = nil
        self.pokelistViewModel = nil
    }

    func testGetPokemonByTypeSuccess() {
        self.repository = PokemonRepository(networkSuccess)
        self.pokelistViewModel = PokemonListViewModel(repository: repository)
        
        self.pokelistViewModel.event = {(res) in
            if !res.isLoading{
                XCTAssert(res.isSuccess && res.obj != nil, "Retorno deveria ser sucesso e obj != nil")
            }
        }
        self.pokelistViewModel.getPokemonByType(url: "www.teste.com")
    }
    
    func testGetPokemonByTypeError() {
        self.repository = PokemonRepository(networkError)
        self.pokelistViewModel = PokemonListViewModel(repository: repository)
        
        self.pokelistViewModel.event = {(res) in
            if !res.isLoading{
                XCTAssert(res.error && res.obj == nil, "Retorno deveria ser error e obj == nil")
            }
        }
        self.pokelistViewModel.getPokemonByType(url: "www.teste.com")
    }
    
    /*func testGetPokemonImageSuccess(){
        self.repository = PokemonRepository(networkSuccess)
        self.pokelistViewModel = PokemonListViewModel(repository: repository)
        
        self.pokelistViewModel.imageEvent = {(res) in
            if !res.isLoading{
                XCTAssert(res.isSuccess && res.obj != nil, "Retorno deveria ser sucesso e obj != nil")
            }
        }
        self.pokelistViewModel.getPokemonImage(imageURL: "www.teste.com")
    }
    
    func testGetPokemonImageError(){
        self.repository = PokemonRepository(networkError)
        self.pokelistViewModel = PokemonListViewModel(repository: repository)
        
        self.pokelistViewModel.imageEvent = {(res) in
            if !res.isLoading{
                XCTAssert(res.error && res.obj == nil, "Retorno deveria ser error e obj == nil")
            }
        }
        self.pokelistViewModel.getPokemonImage(imageURL: "www.teste.com")
    }*/
    
    func testRepositoryJSONData(){
        self.repository = PokemonRepository(networkSuccess)
        self.pokelistViewModel = PokemonListViewModel(repository: repository)
        
        self.pokelistViewModel.event = {(res) in
            if !res.isLoading{
                XCTAssert(res.isSuccess && res.obj != nil, "Objeto deveria ser sucesso e obj != nil")
                if res.isSuccess{
                    let poke = res.obj?.results[0]
                    if let poke = poke{
                        XCTAssert(poke.number != "" && poke.number != nil, "PokeApiInfo deveria ter um number != vazio")
                        XCTAssert(poke.url != "" && poke.url != nil, "PokeApiInfo deveria ter uma url != vazio")
                        XCTAssert(poke.name != "" && poke.name != nil, "PokeApiInfo deveria ter um name != vazio")
                        XCTAssert(poke.imageURL != "" && poke.imageURL != nil
                            , "PokeApiInfo deveria ter uma imageURL != vazio")
                    }
                }
            }
        }
        
        self.pokelistViewModel.getPokemonByType(url: "www.teste.com")
    }


}
