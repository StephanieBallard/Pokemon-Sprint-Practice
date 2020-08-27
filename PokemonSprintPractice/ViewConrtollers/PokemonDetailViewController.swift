//
//  PokemonDetailViewController.swift
//  PokemonSprintPractice
//
//  Created by Stephanie Ballard on 8/26/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var idTextLabel: UILabel!
    @IBOutlet weak var abilitiesTextLabel: UILabel!
    @IBOutlet weak var typeTextLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        if let pokemon = pokemon {
            nameTextLabel.text = pokemon.name
            
        }
    }
    
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        pokemonController?.savePokemon(pokemon: pokemon)
        navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        pokemonController?.fetchPokemon(searchTerm: searchBarText) { (result) in
            switch result {
            case .success(let pokemon):
                print(pokemon)
//                self.pokemon = pokemon
                DispatchQueue.main.async {
                    self.updateViews()
                }
            case .failure(let error):
                print("Error fetching pokemon: \(error)")
            }
        }
    }
}
