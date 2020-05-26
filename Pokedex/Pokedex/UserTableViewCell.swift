//
//  UserTableViewCell.swift
//  Stonks_finalproject
//
//  Created by Yanbing Fang on 5/14/20.
//  Copyright © 2020 Yanbing Fang. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userPokeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureTableCell(item:Item){

        userPokeLabel.text = item.name
        let pokeimage = URL(string: item.image!)
        let data = try? Data(contentsOf:pokeimage!)
        let image = UIImage(data:data!)
        userImage.image = image
        
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
}
