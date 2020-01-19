//
//  ViewController.swift
//  Pokedex
//
//  Created by Eileen Huang on 1/13/20.
//  Copyright © 2020 Eileen Huang. All rights reserved.
//

import UIKit

/* Add Nav bar to switch between views
    1. got to storyboard and click (table)viewcontroller
    2. go to "editor" at the top bar and click "embedded in" -> "Nav Bar"
    3. nav bar becomes the initial view now
        and a title bar is included at the top of view
        change text of title
 */

// inherit from tableviewcontroller because we are using a table view
class ViewController: UITableViewController {
    
    // this VC has a array of pokemons (data)
    var pokemon: [Pokemon] = []
    
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    // OVERRIDE FUNC to change them
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")
        // closure: data response, error (called when task finishes) 
        // need to prefix any field with self.field inside closure
        // URLSession takes the data from api and and returns a string that can be used
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            // data is optional so check if nill
            guard let data = data else {
                return
            }
            // JSONDecoder object, decode method (type to decode into, data to decode
            // try catch to catch error so we dont get invalid object if invalid JSON is decoded
            do {
                // pokemonList is a array of pokemons (struct)
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                // store data from api in the pokemon array variable
                self.pokemon = pokemonList.results
                // need to reload data to show the data in UI
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let error {
                print("\(error)")
            }
        }.resume()
    }
    
    // specify # of sections in table view
    // numberofsections...
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // # of rows in table view section
    // numberOfRows...
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // # of rows is size of pokemon list
        return pokemon.count
    }
    
    // managing cell in table
    // cellforrowat indexpath...
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // returns a UITableViewCell
        
        /* go to storyboard
            1. set table view cell style (basic or other)
            2. set identifier of table view cell
            3. set accessory (disclosure indicator which add the arrow to show that it will take you to another view when tapped)
        */
        
        //reuse cells that are not used
        //get a cell
        // cell variable represents the current row
        // tableView.deq... withIdentifier: String, for: IndexPath...
        // *indexPath is a pair if ints (section, row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        // what to display in each cell
        //change cell text to pokemon name of pokemon at index row
        // ->cell.textLabel?.text
        cell.textLabel?.text = capitalize(text: pokemon[indexPath.row].name)
        
        return cell
    }
    
    // TO USE SEGUE
    // override method in uiviewcontroller to use pokemonsegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // make sure the segue is the one we want by
        // checking the identifier of segue to next VC
        if segue.identifier == "PokemonSegue" {
            // make sure the destination specifically the pokemonVC
            // cast the segue.destination (which is a VC) into a PokemonVC specifically because it has other things that we added which regular VC don't have
            // syntax: if segue.destination cannot be cast to pokemonVC then it will return nil and not enter the block of code
            // but if it can be cast then the destination variable is of type pokemonVC and set to the PokemonVC
            if let destination = segue.destination as? PokemonViewController {
                // passing pokemon info to PokemonVC
                // pokemon in destination.pokemon is the pokemon var declared in PokemonVC.swift
                // index pokemon array with -> tableView.SelectedRow!.row (gets row number which is the same as the index in pokemon array)
                destination.pokemon = pokemon[tableView.indexPathForSelectedRow!.row]
            }
        }
    }

}

