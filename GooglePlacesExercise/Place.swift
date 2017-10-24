//
//  Place.swift
//  GooglePlacesExercise
//
//  Created by Daniel Ku on 10/23/17.
//  Copyright © 2017 djku. All rights reserved.
//

import Foundation

class Place {
    var placeID: String
    var primaryText: String
    var secondaryText: String
    
    init(placeID: String, primaryText: String, secondaryText: String) {
        self.placeID = placeID
        self.primaryText = primaryText
        self.secondaryText = secondaryText
    }
}
