//
//  ViewController.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var types: [TypeModel] = []
    let viewModel = TypeViewModel(repository: PokemonRepository(URLSession.shared))
    
    
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
        viewModel.getTypes()
        
        //Cor da navigation bar
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1.0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //Cor da navigation bar
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1.0)
    }
    
    
    private func observarViewModel(){
        viewModel.event = {(res) in
            DispatchQueue.main.async {
                if res.isLoading {
                    //Loading
                    self.loadingView.isHidden = false
                }else{
                    self.loadingView.isHidden = true
                    if res.isSuccess{
                        //Success
                        if let obj = res.obj{
                            self.types = obj.results
                            self.colView.reloadData()
                        }
                    }else{
                        //Erro
                        print("Erro type view controller")
                    }
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        viewModel.event = {(res) in }
        let tipo = types[indexPath.row]
        self.performSegue(withIdentifier: "pokemonList", sender: tipo)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! TypeCollectionViewCell
        cell.type = types[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonList"{
            let destVC = segue.destination as! PokemonListViewController
            destVC.tipoSelecionado = sender as? TypeModel
            //self.present(destVC, animated: true, completion: nil)
        }
    }
}

