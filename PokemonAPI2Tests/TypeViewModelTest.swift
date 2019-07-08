//
//  PokemonAPI2Tests.swift
//  PokemonAPI2Tests
//
//  Created by dbserver on 08/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import XCTest
@testable import PokemonAPI2
class TypeViewModelTest: XCTestCase {
    
    var typeViewModel: TypeViewModel!
    var repository: PokemonRepository!
    var networkSuccess: NetworkHandler!
    var networkError: NetworkHandler!
    

    override func setUp() {
        self.networkSuccess = NetworkHandlerMock(data: FakeData.typesData!)
        self.networkError = NetworkHandlerMock(error: NSError(domain: "", code: 1, userInfo: nil))
    }

    override func tearDown() {
        self.networkError = nil
        self.networkSuccess = nil
        self.repository = nil
        self.typeViewModel = nil
    }

    func testGetTypesSucesso() {
        self.repository = PokemonRepository(networkSuccess)
        self.typeViewModel = TypeViewModel(repository: repository)
        
        self.typeViewModel.event = {(res) in
            //print("Res: \(res)")
            if !res.isLoading{
                XCTAssert(res.isSuccess && res.obj != nil, "Retorno deveria ser sucesso e obj != nil")
            }
        }
        self.typeViewModel.getTypes()
    }
    
    func testeGetTypesErro(){
        self.repository = PokemonRepository(networkError)
        self.typeViewModel = TypeViewModel(repository: repository)
        
        self.typeViewModel.event = {(res) in
            //print("Res: \(res)")
            if !res.isLoading{
                XCTAssert(res.error && res.obj == nil, "Retorno deveria ser error e obj == nil")
            }
        }
        self.typeViewModel.getTypes()
    }
    
}
