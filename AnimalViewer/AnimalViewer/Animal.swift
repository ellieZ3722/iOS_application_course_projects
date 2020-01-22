//
//  Animal.swift
//  AnimalViewer
//
//  Created by Kiwiinthesky72 on 1/18/20.
//  Copyright © 2020 Kiwiinthesky72. All rights reserved.
//

import AVFoundation
import UIKit

class Animal: CustomStringConvertible{
    let name: String
    let species: String
    let age: Int
    let image: UIImage?
    let soundPath: String
    
    init(name: String, species: String, age: Int, imageName: String, soundPath: String) {
        self.name = name
        self.species = species
        self.age = age
        
        self.image = UIImage(named: imageName)
        
        self.soundPath = soundPath
    }
    
    var description: String {
        return "Animal: name: = \(name), species = \(species), age = \(age)"
    }
}
