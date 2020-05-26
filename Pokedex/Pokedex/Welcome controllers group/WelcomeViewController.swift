//
//  File.swift
//  Stonks_finalproject
//
//  Created by Yanbing Fang on 5/2/20.
//  Copyright © 2020 Jeffrey Cordes. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            
            titleLabel.text = ""
            var charIndex = 0
            let titleText = "⚡️Pokédex"
            for letter in titleText {
                Timer.scheduledTimer(withTimeInterval: 0.3*Double(charIndex), repeats: false){(timer) in
                    self.titleLabel.text?.append(letter)
                }
                charIndex += 1
           }
        }
}
