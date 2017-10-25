//
//  GoogleAPI.swift
//  GooglePlacesExercise
//
//  Created by Daniel Ku on 10/23/17.
//  Copyright © 2017 djku. All rights reserved.
//

import Foundation
import Alamofire

struct GoogleAPI {
    static let APIKey = "AIzaSyD6vDOu5B6qUjnWXngt0MJTIXTO4Rzh6OM"

    static func fetchPlaceInfo(placeID: String, completion: @escaping (Place) -> ()) {
        let searchURL = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeID)&key=\(APIKey)"

        Alamofire.request(searchURL).responseJSON { (response) in
            guard let resp = response.result.value as? [String: Any] else {
                return
            }
            guard let results = resp["result"] as? [String: Any] else {
                return
            }
            
            guard let locationGemoetry = results["geometry"] as? [String: Any] else {
                return
            }
            
            guard let locationPoints = locationGemoetry["location"] as? [String: Any] else {
                return
            }
            let long = locationPoints["lng"] as? Double ?? 0.0
            let lat = locationPoints["lat"] as? Double ?? 0.0
            
            let types = results["types"] as? [String] ?? []
            let typesString = types.joined(separator: ", ")
            
            let url = results["url"] as? String ?? ""
            let rating = results["rating"] as? Double ?? 0.0
            
            let photoList = results["photos"] as? [[String: Any]]
            let photoRef = photoList?[1]["photo_reference"] as? String ?? ""
            
            Alamofire.request("https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoRef)&key=\(APIKey)").responseData(completionHandler: { (response) in
                let placeImage = UIImage(data: response.result.value!)
                let placeInfo = Place(photo: placeImage!, types: typesString, rating: rating, url: url, long: long, lat: lat)
                completion(placeInfo)
            })
        }
    }
    
    static func searchPlace(placesText: String, compeltion: @escaping ([Place]) -> ()) {
        let searchURL = "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=\(APIKey)&input=\(placesText)"
        var searchResults = [Place]()
        
        Alamofire.request(searchURL).responseJSON { (response) in
            guard let resp = response.result.value as? [String: Any] else {
                print("network error")
                return
            }
            
            if let results = resp["predictions"] as? [[String: Any]] {
                for result in results {
                    let formattedName = result["structured_formatting"] as? [String: Any]
                    
                    let place = Place(placeID: result["place_id"] as? String ?? "", primaryText: formattedName?["main_text"] as? String ?? "", secondaryText: formattedName?["secondary_text"] as? String ?? "")
                    searchResults.append(place)
                }
            }
            
            compeltion(searchResults)
        }
    }
}
