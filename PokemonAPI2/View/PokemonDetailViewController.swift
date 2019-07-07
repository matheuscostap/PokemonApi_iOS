//
//  PokemonDetailViewController.swift
//  PokemonAPI2
//
//  Created by dbserver on 05/07/19.
//  Copyright © 2019 matheus. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType1: UILabel!
    @IBOutlet weak var lblType2: UILabel!
    @IBOutlet weak var lblAltura: UILabel!
    @IBOutlet weak var lblPeso: UILabel!
    @IBOutlet weak var tableHabilidades: UITableView!
    @IBOutlet weak var ivPokemon: UIImageView!
    @IBOutlet weak var viewInfos: UIView!
    
    let viewModel = PokemonDetailViewModel(repository: PokemonRepository.instance)
    
    var pokemon: PokemonModel?
    var pokemonSelecionado: PokemonApiInfo?
    var type: TypeModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableHabilidades.delegate = self
        self.tableHabilidades.dataSource = self
        
        observarViewModel()
        if let selec = pokemonSelecionado{
            viewModel.getPokemon(url: selec.url)
            viewModel.getPokemonImage(imageURL: selec.imageURL)
        }
        
        if let type = type{
            self.view.backgroundColor = type.getColor()
            self.navigationController?.navigationBar.barTintColor = type.getColor()
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        }
        
        //Radius na view das infos
        viewInfos.clipsToBounds = true
        viewInfos.layer.cornerRadius = 50
        viewInfos.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        //Botao share
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(compartilhar))
        
        //Trazer o loading pra frente
        self.view.bringSubviewToFront(loadingView)
    }
    
    
    @objc private func compartilhar(){
        let itens = [self.formatarInfos()]
        let activityVC = UIActivityViewController(activityItems: itens, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    private func formatarInfos() -> String{
        var textoShare = """
        \(pokemonSelecionado?.name.capitalized ?? "")
        Altura: \(pokemon?.height ?? 0)
        Peso: \(pokemon?.weight ?? 0)
        Tipo:
        """
        
        pokemon?.types.forEach({ (type) in
            textoShare += " \(type.name)"
        })
        
        textoShare += "\nHabilidades: "
        
        pokemon?.moves.forEach({ (move) in
            textoShare += "\n\(move.name)"
        })
        
        return textoShare
    }
    
    
    private func observarViewModel(){
        viewModel.event = { (res) in
            DispatchQueue.main.async {
                if res.isLoading{
                    //Loading
                    //self.loadingView.isHidden = false
                }else{
                    //self.loadingView.isHidden = true
                    if res.isSuccess{
                        //Success
                        if let pokemon = res.obj{
                            self.pokemon = pokemon
                            self.pokemon?.name = self.pokemonSelecionado?.name
                            self.preencherTela()
                            self.tableHabilidades.reloadData()
                        }
                    }else{
                        //Error
                        print("Erro pokemon detail view controller")
                    }
                }
            }
        }
        
        //Imagem
        viewModel.imageEvent = { (data) in
            DispatchQueue.main.async {
                if data.isLoading{
                    //Loading
                    self.loadingView.isHidden = false
                }else{
                    self.loadingView.isHidden = true
                    if data.isSuccess{
                        //Success
                        if let data = data.obj{
                            self.ivPokemon.image = UIImage(data: data)
                        }
                    }else{
                        //Error
                        print("Erro pokemon detail view controller")
                    }
                }
            }
        }
    }
    
    
    private func preencherTela(){
        if let pokemon = self.pokemon{
            self.lblName.text = pokemon.name?.capitalized
            self.lblType1.text = pokemon.types[0].name.uppercased()
            self.lblType1.backgroundColor = pokemon.types[0].getColor()
            
            if pokemon.types.count > 1{
                self.lblType2.text = pokemon.types[1].name.uppercased()
                self.lblType2.backgroundColor = pokemon.types[1].getColor()
            }else{
                self.lblType2.isHidden = true
            }
            
            let height = pokemon.height * 10 //decimetros para centimetros
            let weight = pokemon.weight * 100 //hectograma para grama
            self.lblAltura.text = "\(height)cm"
            self.lblPeso.text = "\(weight)g"
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemon?.moves.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell") as! UITableViewCell
        cell.textLabel?.text = self.pokemon?.moves[indexPath.row].name ?? ""
        return cell
    }
    
}
