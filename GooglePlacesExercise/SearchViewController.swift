//
//  SearchViewController.swift
//  GooglePlacesExercise
//
//  Created by Daniel Ku on 10/20/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchViewController: UIViewController {
    @IBOutlet weak var placesSearchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    var searchResults = [Place]()
    var placesClient: GMSPlacesClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
        placesSearchBar.delegate = self
        
        placesClient = GMSPlacesClient.shared()

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
        
        placesClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeID)")
                return
            }
            
            //Add info to place reference
            
            self.performSegue(withIdentifier: "toPlaceInfoVC", sender: nil)
        })
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let placesText = searchText
        searchResults = []
        
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        placesClient.autocompleteQuery(placesText, bounds: nil, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                for result in results {
                    let place = Place(placeID: result.placeID ?? "", primaryText: result.attributedPrimaryText.string, secondaryText: result.attributedSecondaryText?.string ?? "")
                    self.searchResults.append(place)
                }
                self.searchResultsTableView.reloadData()
            }
        })

    }
}

