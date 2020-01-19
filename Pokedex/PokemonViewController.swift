//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Eileen Huang on 1/13/20.
//  Copyright © 2020 Eileen Huang. All rights reserved.
//

import UIKit

/*
 Storyboard
 
 1. Add label for text
 2. drag size to left and right to resize
 3. change font size etc...
 
 creating segue from first VC to second VC
 1. drag from cell to second VC
 2. select segue ("show" to show second VC...)
 3. click segue (the arrow thing)
 4. set identifier
 
 TO use segue go to first VC.swift
 */

// file for second view
// inherit from UIViewController
class PokemonViewController: UIViewController {
    //connecting name/numberLabel to view in pokemonviewcontroller
    // IBOutlet is used to connect the labels in VC to swift source to manipulate the text
    // var because its mutable (changes according to pokemon)
    // type is UILabel (add ! so you don't have to worry abour if label var is nil or not)
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    
    // create a pokemon object of type Pokemon(the struct with name and number)
    // when first VC transitions to this VC it passes the Pokemon info
    var pokemon: Pokemon!
    
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    // load the pokemon info in view
    override func viewDidLoad() {
        super.viewDidLoad() // call super to make sure that everything in this function also runs when view loads
        
        type1Label.text = ""
        type2Label.text = ""
        
        let url = URL(string: pokemon.url)
        guard let u = url else {
            return
        }
        
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                
                DispatchQueue.main.async {
                    self.nameLabel.text = self.capitalize(text: self.pokemon.name)
                    self.numberLabel.text = String(format: "#%03d", pokemonData.id)
                    // change pokemon.number from Int -> String with format of "#%03d" (# + 3 digits; d for integer)
                    for typeEntry in pokemonData.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = typeEntry.type.name
                        }
                        else if typeEntry.slot == 2 {
                            self.type2Label.text = typeEntry.type.name
                        }
                    }
                }
            }
            catch let error {
                print("\(error)")
            }
        }.resume()
    }
}

/* storyboard -> right panel -> identity inspector (box in box icon)
 1. set class of new view controller to this class
 2. hold Ctrl(^) + drag from viewcontroller tab to label then let go and choose var/IBoutlet for that label
    - now everytime you reference that var in swift file it will manioulate that label
 */
