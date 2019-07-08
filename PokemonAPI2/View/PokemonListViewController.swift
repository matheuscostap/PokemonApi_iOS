//
//  PokemonListViewController.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    var tipoSelecionado: TypeModel?
    var pokemons: [PokemonApiInfo] = []
    let viewModel = PokemonListViewModel(repository: PokemonRepository(URLSession.shared))
    
    @IBAction func teste(_ sender: Any) {
        self.performSegue(withIdentifier: "pokemonDetail", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colView.delegate = self
        self.colView.dataSource = self
        
        //Configura o tamanho da cell
        let tamanho = self.view.frame.size.width / 2
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = CGSize(width: tamanho, height: tamanho)
        
        observarViewModel()
        if let url = tipoSelecionado?.url{
            viewModel.getPokemonByType(url: url)
        }
        
        print("Tipo selecionado \(tipoSelecionado?.name)")
        
        //Cor da navigation bar
        self.navigationController?.navigationBar.barTintColor = tipoSelecionado?.getColor()
        //Titulo da navigation bar
        self.title = tipoSelecionado?.name.capitalized
    }
    
    
    private func observarViewModel(){
        viewModel.event = { (res) in
            DispatchQueue.main.async {
                if res.isLoading{
                    //Loading
                    self.loadingView.isHidden = false
                }else{
                    self.loadingView.isHidden = true
                    if res.isSuccess{
                        //Success
                        if let pokemons = res.obj?.results{
                            self.pokemons = pokemons
                            self.colView.reloadData()
                        }
                    }else{
                        //Error
                        print("Erro pokemon list view controller")
                    }
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke = pokemons[indexPath.row]
        self.performSegue(withIdentifier: "pokemonDetail", sender: poke)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as! PokemonListCollectionViewCell
        cell.pokemon = pokemons[indexPath.row]
        cell.type = tipoSelecionado
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetail"{
            let destVC = segue.destination as! PokemonDetailViewController
            destVC.pokemonSelecionado = sender as? PokemonApiInfo
            destVC.type = self.tipoSelecionado
        }
    }
    
}
