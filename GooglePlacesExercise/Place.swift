//
//  Place.swift
//  GooglePlacesExercise
//
//  Created by Daniel Ku on 10/23/17.
//  Copyright © 2017 djku. All rights reserved.
//

import Foundation
import UIKit

class Place {
    var placeID: String
    var primaryText: String
    var secondaryText: String
    var photo: UIImage?
    var types: String?
    var rating: Double?
    var url: String?
    var longitutde: Double?
    var latitutde: Double?
    
    init(placeID: String, primaryText: String, secondaryText: String) {
        self.placeID = placeID
        self.primaryText = primaryText
        self.secondaryText = secondaryText
    }
    
    convenience init(photo: UIImage, types: String, rating: Double, url: String, long: Double, lat: Double) {
        self.init(placeID: "", primaryText: "'", secondaryText: "")
        self.photo = photo
        self.types = types
        self.rating = rating
        self.url = url
        self.longitutde = long
        self.latitutde = lat
    }
    
    func updatePlaceInfo(place: Place) {
        self.photo = place.photo
        self.types = place.types
        self.rating = place.rating
        self.url = place.url
        self.longitutde = place.longitutde
        self.latitutde = place.latitutde
    }
}
