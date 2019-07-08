//
//  PokemonAPI2UITests.swift
//  PokemonAPI2UITests
//
//  Created by dbserver on 08/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import XCTest

class PokemonAPI2UITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false

        self.app = XCUIApplication()
        self.app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        app.terminate()
    }

    func testTypeListToPokemonList() {
        app.launch()
        
        let originVC = app.otherElements["Type List"].exists
        XCTAssertTrue(originVC, "Não está na tela de lista de tipos")
        
        app.collectionViews.children(matching: .any).element(boundBy: 0).tap()
        let sourceVC = app.otherElements["Pokemon List"].exists
        XCTAssertTrue(sourceVC, "Não foi para a tela de lista de pokemons")
    }
    
    func testPokemonListTitle(){
        app.launch()
        
        //Pega a label do tipo selecionado
        sleep(5)
        let cells = app.collectionViews.cells
        let selectedType = cells.staticTexts.element(boundBy: 0).label
        print("Type -> \(selectedType.capitalized)")
        
        //Clica no primeiro tipo da lista
        app.collectionViews.children(matching: .any).element(boundBy: 0).tap()
        let navBar = app.navigationBars[selectedType.capitalized]
        
        XCTAssertTrue(navBar.exists, "Titulo não é o mesmo que o tipo selecionado")
    }

}
