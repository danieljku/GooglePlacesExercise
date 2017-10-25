//
//  PlaceInfoViewController.swift
//  GooglePlacesExercise
//
//  Created by Daniel Ku on 10/23/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class PlaceInfoViewController: UIViewController {
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypesLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    var place: Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeImageView.image = place?.photo
        placeNameLabel.text = place?.primaryText
        placeTypesLabel.text = place?.types
        ratingImageView.image = setRating((place?.rating)!)
    }

    func setRating(_ rating: Double) -> UIImage {
        var ratingImage = UIImage()
        
        if(rating == 1.0 || rating == 0.5 || rating == 1.5) {
            ratingImage = #imageLiteral(resourceName: "1rating")
        } else if( rating == 2 ) {
            ratingImage = #imageLiteral(resourceName: "2rating")
        } else if(rating == 2.5 ) {
            ratingImage = #imageLiteral(resourceName: "2andhalfrating")
        }else if(rating == 3) {
            ratingImage = #imageLiteral(resourceName: "3rating")
        } else if(rating == 3.5 ) {
            ratingImage = #imageLiteral(resourceName: "3andhalfrating")
        } else if( rating == 4 ) {
            ratingImage = #imageLiteral(resourceName: "4rating")
        } else if(rating == 4.5 ) {
            ratingImage = #imageLiteral(resourceName: "4andhalfRating")
        } else {
            ratingImage = #imageLiteral(resourceName: "5rating")
        }
        
        return ratingImage
    }

    @IBAction func onDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onOpenMaps(_ sender: Any) {
    }
    
    @IBAction func onOpenBrowser(_ sender: Any) {
    }
}
