//
//  SearchViewController.swift
//  GooglePlacesExercise
//
//  Created by Daniel Ku on 10/20/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var placesSearchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var networkErrorLabel: UILabel!
    
    var searchResults = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
        placesSearchBar.delegate = self
        
        if CheckNetworkHelper.isConnectedToNetwork() == false {
            searchResultsTableView.isHidden = true
        } else {
            networkErrorLabel.isHidden = true
        }
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
        
        ActivitySpinnerHelper.startSpinning()
        GoogleAPI.fetchPlaceInfo(placeID: placeID) { (place) in
            self.searchResults[indexPath.row].updatePlaceInfo(place: place)
            
            ActivitySpinnerHelper.stopSpinning()
            self.view.endEditing(true)
            self.performSegue(withIdentifier: "toPlaceInfoVC", sender: nil)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults = []
        
        let placesText = searchText
        let placesEncodedText = placesText.replacingOccurrences(of: " ", with: "+")
        
        GoogleAPI.searchPlace(placesText: placesEncodedText) { (places) in
            self.searchResults = places
            self.searchResultsTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

