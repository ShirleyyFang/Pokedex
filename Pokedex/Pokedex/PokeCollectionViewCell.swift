//
//  PokeCollectionViewCell.swift
//  Stonks_finalproject
//
//  Created by Yanbing Fang on 5/12/20.
//  Copyright © 2020 Yanbing Fang. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var pokeImage1: UIImageView!
    
    func configure(with pokemodel:PokemonModel){
        label1.text = pokemodel.name
        let realImageUrl = URL(string:pokemodel.imageUrl)
        let data = try? Data(contentsOf: realImageUrl!)
        let image = UIImage(data: data!)
        pokeImage1.image = image
    }
    
}
