//
//  PokemonTableViewCell.swift
//  PokemonSprintPractice
//
//  Created by Stephanie Ballard on 8/26/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonNameTextLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        pokemonNameTextLabel.text = pokemon.name
    }

}
