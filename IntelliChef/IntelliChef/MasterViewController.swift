//
//  MasterViewController.swift
//  IntelliChef
//
//  Created by Joey Murphy on 2/3/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import UIKit

extension MasterViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }

}

class MasterViewController: UITableViewController {
  
  // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    var detailViewController: DetailViewController? = nil
    var recipes = [Recipe]()
    var filteredRecipes = [Recipe]()
  
  // MARK: - View Setup
  override func viewDidLoad() {
    super.viewDidLoad()

    if let splitViewController = splitViewController {
      let controllers = splitViewController.viewControllers
      detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
    }
    recipes = [
        Recipe(category:"Entree", name:"Spaghetti"),
        Recipe(category:"Appetizer", name:"Garlic Bread"),
        Recipe(category:"Dessert", name:"Tiramisu"),
        Recipe(category:"Entree", name:"Burger"),
        Recipe(category:"Appetizer", name:"Garlic Bread"),
        Recipe(category:"Dessert", name:"Tiramisu"),
        Recipe(category:"Entree", name:"Spaghetti"),
        Recipe(category:"Appetizer", name:"Garlic Bread"),
        Recipe(category:"Dessert", name:"Tiramisu"),

    ]
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    tableView.tableHeaderView = searchController.searchBar
  }
  
  override func viewWillAppear(_ animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredRecipes = recipes.filter { recipe in
            return recipe.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let recipe = recipes[indexPath.row]
    cell.textLabel!.text = recipe.name
    cell.detailTextLabel!.text = recipe.category
    return cell
  }
  
  // MARK: - Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let recipe = recipes[indexPath.row]
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.detailItem = recipe
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  }
  
}

