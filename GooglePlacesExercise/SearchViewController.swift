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
    
    var searchResults = [String]()
    var placesClient: GMSPlacesClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultsTableView.dataSource = self
        placesSearchBar.delegate = self
        
        placesClient = GMSPlacesClient.shared()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        cell.nameLabel.text = searchResults[indexPath.row]
        
        return cell
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
                    let place = result.attributedFullText.string
                    self.searchResults.append(place)
                }
                self.searchResultsTableView.reloadData()
            }
        })

    }
}

