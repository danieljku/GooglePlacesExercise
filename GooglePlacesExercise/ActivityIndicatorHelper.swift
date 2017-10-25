//
//  ActivityIndicatorHelper.swift
//  GooglePlacesExercise
//
//  Created by Daniel Ku on 10/25/17.
//  Copyright © 2017 djku. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

struct ActivitySpinnerHelper {
    static func startSpinning() {
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    static func stopSpinning() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
