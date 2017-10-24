//
//  PlaceInfoViewController.swift
//  GooglePlacesExercise
//
//  Created by Daniel Ku on 10/23/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class PlaceInfoViewController: UIViewController {
    
    var place: Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(place?.primaryText)
    }


}
