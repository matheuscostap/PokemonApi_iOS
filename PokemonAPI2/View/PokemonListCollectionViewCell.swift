//
//  PokemonListCollectionViewCell.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import UIKit

class PokemonListCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var lblNumero: UILabel!
    @IBOutlet weak var ivPokemon: UIImageView!
    
    
    var pokemon: PokemonApiInfo!{
        didSet{
            self.lblNome.text = pokemon.name.capitalized
            self.lblNumero.text = "#\(pokemon.number)"
        }
    }
    
    var type: TypeModel!{
        didSet{
            self.lblNome.backgroundColor = type.getColor()
        }
    }
    
}
