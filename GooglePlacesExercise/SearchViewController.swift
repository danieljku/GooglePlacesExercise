//
//  SearchViewController.swift
//  GooglePlacesExercise
//
//  Created by Daniel Ku on 10/20/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    @IBOutlet weak var placesSearchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    var searchResults = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
        placesSearchBar.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let placeInfoVC = segue.destination as! PlaceInfoViewController
        placeInfoVC.place = searchResults[(searchResultsTableView.indexPathForSelectedRow?.row)!]
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        cell.place = searchResults[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeID = searchResults[indexPath.row].placeID
        let APIKey = "AIzaSyD6vDOu5B6qUjnWXngt0MJTIXTO4Rzh6OM"
        
        let searchURL = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeID)&key=\(APIKey)"
        
        Alamofire.request(searchURL).responseJSON { (response) in
            let resp = response.result.value as! [String: Any]
            print(resp["result"])
            
            //Add info to place reference

            self.performSegue(withIdentifier: "toPlaceInfoVC", sender: nil)

        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = []
        
        let APIKey = "AIzaSyD6vDOu5B6qUjnWXngt0MJTIXTO4Rzh6OM"
        
        let placesText = searchText
        let placesEncodedText = placesText.replacingOccurrences(of: " ", with: "+")
        
        let searchURL = "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=\(APIKey)&input=\(placesEncodedText)"
        
        Alamofire.request(searchURL).responseJSON { (response) in
            let resp = response.result.value as! [String: Any]

            if let results = resp["predictions"] as? [[String: Any]] {
                for result in results {
                    let formattedName = result["structured_formatting"] as? [String: Any]

                    let place = Place(placeID: result["place_id"] as? String ?? "", primaryText: formattedName?["main_text"] as? String ?? "", secondaryText: formattedName?["secondary_text"] as? String ?? "")
                    self.searchResults.append(place)
                }
                self.searchResultsTableView.reloadData()
            }
        }
    }
}

