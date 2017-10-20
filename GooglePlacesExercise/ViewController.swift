//
//  ViewController.swift
//  GooglePlacesExercise
//
//  Created by Daniel Ku on 10/20/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController {
    @IBOutlet weak var placesTextField: UITextField!
    var placesClient: GMSPlacesClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        placesClient = GMSPlacesClient.shared()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTextChange(_ sender: Any) {
        let placesText = placesTextField.text ?? ""
        
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        placesClient.autocompleteQuery(placesText, bounds: nil, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                for result in results {
                    print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                }
            }
        })
    }


}

