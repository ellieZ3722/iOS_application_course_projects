//
//  ViewController.swift
//  AnimalViewer
//
//  Created by Kiwiinthesky72 on 1/18/20.
//  Copyright © 2020 Kiwiinthesky72. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var animals: [Animal]!
    var player: AVAudioPlayer!

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.animals = []
        
        //print(Bundle.main.path(forResource: "Original-cat-sound.mp3", ofType: nil, inDirectory: "Sounds"))
        
        
        let cat = Animal(name: "Sushi", species: "Chinese garden cat", age: 3, imageName: "cat", soundPath: Bundle.main.path(forResource: "Original-cat-sound", ofType: "mp3", inDirectory: "Sounds")!)
        self.animals.append(cat)
        
        let dog = Animal(name: "Pun", species: "Shiba", age: 5, imageName: "dog", soundPath: Bundle.main.path(forResource: "Dog-whimpering-sound", ofType: "mp3", inDirectory: "Sounds")!)
        self.animals.append(dog)
        
        let panda = Animal(name: "Dumpling", species: "Panda", age: 10, imageName: "panda", soundPath: Bundle.main.path(forResource: "Bear-sounds", ofType:"mp3", inDirectory: "Sounds")!)
        self.animals.append(panda)
        
        animals.shuffle()
        
        //Set up scroll view
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 1242, height: 600)
        scrollView.backgroundColor = UIColor.white
        
        label.text = animals[0].species
        
        var buttons: [UIButton] = []
    
        for i in 0...2 {
            let button = UIButton(type: .system)
            buttons.append(button)
            scrollView.addSubview(buttons[i])
            buttons[i].frame = CGRect(x: i * 414, y: 0, width: 414, height: 200)
            buttons[i].setTitle(animals[i].name, for: .normal)
            buttons[i].tag = i
            
            buttons[i].addTarget(self, action: #selector(buttonTapped), for:.touchUpInside)
        }
        
        var imageViews: [UIImageView] = []
        
        for i in 0...2 {
            let imageView = UIImageView()
            imageViews.append(imageView)
            imageViews[i].image = animals[i].image
            scrollView.addSubview(imageViews[i])
            imageViews[i].frame = CGRect(x: i * 414, y: 200, width: 414, height: 400)
        }
        
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        let animal = animals[button.tag]
        let alert = UIAlertController(title: animal.name, message: "This \(animal.species) is \(animal.age) years old", preferredStyle: .alert)
        
        let playSound = UIAlertAction(title: "Play Sound", style: UIAlertAction.Style.default) { (action) in
            do {
                self.player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: animal.soundPath))
                self.player.play()
                print(animal.description)
            } catch {
                print("Can't load file")
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style:  UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(playSound)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index: Int = Int(scrollView.contentOffset.x + 207) / 414
        label.text = animals[index].species
        
        let alphaCal = Int(scrollView.contentOffset.x) % 414
        if (alphaCal <= 207) {
            label.alpha = CGFloat(1.0 - Double(alphaCal)/207)
        } else {
            label.alpha = CGFloat(1.0 - Double(414 - alphaCal)/207)
        }
    }
}

