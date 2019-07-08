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
    let viewModel = PokemonListViewModel(repository: PokemonRepository(URLSession.shared))
    
    
    var pokemon: PokemonApiInfo!{
        didSet{
            self.lblNome.text = pokemon.name.capitalized
            self.lblNumero.text = "#\(pokemon.number)"
            
            //Imagem
            viewModel.imageEvent = { (data) in
                DispatchQueue.main.async {
                    if data.isLoading{
                        //Loading
                        //self.loadingView.isHidden = false
                    }else{
                        //self.loadingView.isHidden = true
                        if data.isSuccess{
                            //Success
                            if let data = data.obj{
                                self.ivPokemon.image = UIImage(data: data)
                            }
                        }else{
                            //Error
                            print("Erro pokemon list view controller")
                        }
                    }
                }
            }
            
            viewModel.getPokemonImage(imageURL: pokemon.imageURL)
        }
    }
    
    var type: TypeModel!{
        didSet{
            self.lblNome.backgroundColor = type.getColor()
        }
    }
    
}
