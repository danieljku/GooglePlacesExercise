
//
//  SearchTableViewCell.swift
//  GooglePlacesExercise
//
//  Created by Daniel Ku on 10/23/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var primaryText: UILabel!
    @IBOutlet weak var secondaryText: UILabel!
    
    var place: Place! {
        didSet {
            primaryText.text = place.primaryText
            secondaryText.text = place.secondaryText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
