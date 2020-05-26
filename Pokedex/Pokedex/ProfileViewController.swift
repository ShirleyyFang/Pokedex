//
//  ProfileViewController.swift
//  Stonks_finalproject
//
//  Created by Yanbing Fang on 4/27/20.
//  Copyright © 2020 Yanbing Fang. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var frameImage: UIImageView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var pokeBall: UIImageView!
    
    var pulseLayers = [CAShapeLayer]()
    
    var name = ""
    var img = ""
    var descri = ""
    var height = 0
    var weight = 0
    var attack = 0
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPulse()
        
        nameLabel.text = name
        
        let pokeimage = URL(string: img)
        let data = try? Data(contentsOf:pokeimage!)
        let image = UIImage(data:data!)
        pokeImage.image = image
        
        descriptionLabel.text = descri
        heightLabel.text = String(height)
        weightLabel.text = String(weight)
        attackLabel.text = String(attack)
        typeLabel.text = type
        
        frameImage.layer.masksToBounds = true
        frameImage.layer.cornerRadius = 8.0
        
    }
    
    @IBAction func PokeButton(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newItem = Item(context:context)
        newItem.name = name
        newItem.image = img
        self.saveItems()
        
    }
    
    func saveItems(){
        do{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            try context.save()
            print("saved context")
        }catch{
            print("Error saving context\(error)")
        }
    }

//MARK: - animation
    func createPulse() {
        for _ in 0...2 {
            let circularPath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.size.width/2.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            let pulseLayer = CAShapeLayer()
            pulseLayer.path = circularPath.cgPath
            pulseLayer.lineWidth = 2.0
            pulseLayer.fillColor = UIColor.clear.cgColor
            pulseLayer.lineCap = CAShapeLayerLineCap.round
            pulseLayer.position = CGPoint(x: pokeBall.frame.size.width/2.0, y: pokeBall.frame.size.width/2.0)
            pokeBall.layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.animatePulse(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.animatePulse(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.animatePulse(index: 2)
                }
            }
        }
    }
    
    func animatePulse(index: Int) {
        pulseLayers[index].strokeColor = UIColor.black.cgColor

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 2.0
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.9
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(scaleAnimation, forKey: "scale")
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 2.0
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(opacityAnimation, forKey: "opacity")
    }

}
