//
//  PokemonTableViewController.swift
//  PokemonSprintPractice
//
//  Created by Stephanie Ballard on 8/25/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonController.fetchPokemon(searchTerm: "charmander") { _ in
    }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokedex.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        let pokemon = pokemonController.pokedex[indexPath.row]
        cell.pokemon = pokemon

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokedex.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchShowSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController else { return }
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "PokemonDetailShowSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.pokemon = pokemonController.pokedex[indexPath.row]
        }
    }
    

}
