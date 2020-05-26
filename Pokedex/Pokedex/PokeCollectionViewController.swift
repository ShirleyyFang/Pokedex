//
//  PokeCollectionViewController.swift
//  Stonks_finalproject
//
//  Created by Yanbing Fang on 5/12/20.
//  Copyright © 2020 Yanbing Fang. All rights reserved.
//

import UIKit

class PokeCollectionViewController: UICollectionViewController {

    var pokemon = [PokemonModel]()
    var api = APIClient()
    
    override func viewDidLoad() {
        api.delegate = self
        api.fetchData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(pokemon.count)
        return pokemon.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        if let pokeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PokeCollectionViewCell {
            pokeCell.configure(with:pokemon[indexPath.row])
            cell = pokeCell
        }
        cell.layer.cornerRadius = 8.0
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.red.cgColor
        cell?.layer.borderWidth = 2
        performSegue(withIdentifier: "goToProfile", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfile" {
            if let destination = segue.destination as? ProfileViewController{
                let indexPath = self.collectionView.indexPathsForSelectedItems?.first
                 //destination.nameLabel.text would crash
                destination.name = pokemon[indexPath?.row ?? 0].name
                destination.img = pokemon[indexPath?.row ?? 0].imageUrl
                destination.descri = pokemon[indexPath?.row ?? 0].description
                destination.height = pokemon[indexPath?.row ?? 0].height
                destination.weight = pokemon[indexPath?.row ?? 0].weight
                destination.attack = pokemon[indexPath?.row ?? 0].attack
                destination.type = pokemon[indexPath?.row ?? 0].type
            }
        }
    }

    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 0.5
    }
}

//Networking
extension PokeCollectionViewController:PokemonProtocol{
    
    func didUpdatePokemon(_ APIClient: APIClient,pokemonList:[PokemonModel]) {
        print("did update pokemon")
        DispatchQueue.main.async{
            self.pokemon = pokemonList
        
            self.collectionView.reloadData() //important!
        }
    }
    
    func responseError(error: Error) {
        DispatchQueue.main.async{
            print("fail")
        }
    }
}
