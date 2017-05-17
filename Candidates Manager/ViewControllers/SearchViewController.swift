//
//  SearchViewController.swift
//  Candidates Manager
//
//  Created by Bassem Abbas on 5/17/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UITableViewController {
        
        // MARK: - Properties
        var detailViewController: DetailViewController? = nil
        var candidates = [Candidate]()
        var filteredCandidatess = [Candidate]()
        let searchController = UISearchController(searchResultsController: nil)
        
        // MARK: - View Setup
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Setup the Search Controller
            searchController.searchResultsUpdater = self
            searchController.searchBar.delegate = self
            searchController.hidesNavigationBarDuringPresentation = false;
        
            definesPresentationContext = true
            searchController.dimsBackgroundDuringPresentation = false
            tableView.tableHeaderView = searchController.searchBar
            
            //Get Data from Realm
            
            do {
                let realm = try Realm();
                
              self.candidates  =   realm.objects(Candidate).toArray()
                
            } catch  {
                
            }
            
            

        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        // MARK: - Table View
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if searchController.isActive && searchController.searchBar.text != "" {
                return filteredCandidatess.count
            }
            return candidates.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let candy: Candidate
            if searchController.isActive && searchController.searchBar.text != "" {
                candy = filteredCandidatess[indexPath.row]
            } else {
                candy = candidates[indexPath.row]
            }
            cell.textLabel!.text = candy.name
            cell.detailTextLabel!.text = candy.position
            return cell
        }
        
        func filterContentForSearchText(_ searchText: String, scope: String? = nil) {
            filteredCandidatess = candidates.filter({( cand : Candidate) -> Bool in

                return  cand.name.lowercased().contains(searchText.lowercased()) ||  cand.position.lowercased().contains(searchText.lowercased())
            })
            tableView.reloadData()
        }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let candy: Candidate
            if searchController.isActive && searchController.searchBar.text != "" {
                candy = filteredCandidatess[indexPath.row]
            } else {
                candy = candidates[indexPath.row]
            }
            let stb = UIStoryboard(storyboard: .Main);
            let detailVC:DetailViewController = stb.instantiateViewController();
            detailVC.detailCandy = candy;
            self.navigationController?.pushViewController(detailVC, animated: true);
            
            
        }
        
        
       
        
    }
    
        // MARK: - Segues
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetail" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let candy: Candidate
                    if searchController.isActive && searchController.searchBar.text != "" {
                        candy = filteredCandidatess[indexPath.row]
                    } else {
                        candy = candidates[indexPath.row]
                    }
                    let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                    controller.detailCandy = candy
                    controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
            }
        }
        
    }
    
    extension SearchViewController: UISearchBarDelegate {
        // MARK: - UISearchBar Delegate
        func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            filterContentForSearchText(searchBar.text!, scope: nil)
        }
        
        func  searchBarCancelButtonClicked(_ searchBar: UISearchBar){
            self.tableView.reloadData()
        }

        
       
        
        
    }
    
    extension SearchViewController: UISearchResultsUpdating {
        // MARK: - UISearchResultsUpdating Delegate
        func updateSearchResults(for searchController: UISearchController) {
            let searchBar = searchController.searchBar
            if let text = searchBar.text {
            filterContentForSearchText(text, scope: nil)
            }
        }
}
