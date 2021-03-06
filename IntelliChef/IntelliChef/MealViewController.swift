//
//  MealViewController.swift
//  IntelliChef
//
//  Created by Joey Murphy on 2/4/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import UIKit

class MealViewController: UITableViewController {
    
    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    var detailViewController: DetailViewController? = nil
    var recipes = [Recipe]()
    var filteredRecipes = [Recipe]()
    var makeMeal = false

    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        searchController.searchBar.searchBarStyle = UISearchBarStyle(rawValue: 2)!
        self.tableView.allowsMultipleSelection = true
        
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
        recipes = [
            Recipe(category:"Entree", name:"Spaghetti"),
            Recipe(category:"Appetizer", name:"Garlic Bread"),
            Recipe(category:"Dessert", name:"Tiramisu"),
            Recipe(category:"Entree", name:"Burger"),
            Recipe(category:"Appetizer", name:"Wings"),
            Recipe(category:"Dessert", name:"Vanilla Sundae"),
            Recipe(category:"Entree", name:"Chicken"),
            Recipe(category:"Appetizer", name:"Ceaser Salad"),
            Recipe(category:"Dessert", name:"Greek Yogurt"),
            Recipe(category:"Entree", name:"Mac & Cheese"),
            Recipe(category:"Appetizer", name:"Shrimp Fried Rice"),
            Recipe(category:"Dessert", name:"Bread Pudding"),
            Recipe(category:"Entree", name:"Potato Salad"),
            Recipe(category:"Appetizer", name:"Cole Slaw"),
            Recipe(category:"Dessert", name:"Homemade Potato Chips"),
            Recipe(category:"Entree", name:"Steak"),
            Recipe(category:"Appetizer", name:"Apple Pie"),
            Recipe(category:"Dessert", name:"Pumpkin PIe")
            
        ]
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
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredRecipes.count
        }
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none // to prevent cells from being "highlighted
        let recipe: Recipe
        if searchController.isActive && searchController.searchBar.text != "" {
            recipe = filteredRecipes[indexPath.row]
        } else {
            recipe = recipes[indexPath.row]
        }
        let attrName = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17)]
        let boldName = NSMutableAttributedString(string:recipe.name, attributes:attrName)
        let attrElse = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        let boldPrep = NSMutableAttributedString(string:recipe.prepTime, attributes:attrElse)
        let boldCook = NSMutableAttributedString(string:recipe.cookTime, attributes:attrElse)
        cell.textLabel?.attributedText = boldName
        let prep = "Preparation: "
        let cook = "        Cook: "
        let normPrep = NSMutableAttributedString(string:prep)
        let normCook = NSMutableAttributedString(string:cook)
        let combo = NSMutableAttributedString()
        combo.append(normPrep)
        combo.append(boldPrep)
        combo.append(normCook)
        combo.append(boldCook)
        cell.detailTextLabel?.attributedText = combo
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Custom Table Formatting
        tableView.separatorStyle = UITableViewCellSeparatorStyle(rawValue: 52)!
        tableView.separatorColor = UIColor.clear
        self.tableView.layer.masksToBounds = true
        self.tableView.backgroundColor = UIColor(red: 25/255, green: 62/255, blue: 78/255, alpha: 1.0)
        // Custom Cell Formatting
        cell.backgroundColor = UIColor(red: 161/255, green: 208/255, blue: 216/255, alpha: 0.5)
        cell.layer.cornerRadius = 7
        cell.textLabel?.textColor =  UIColor(red: 142/255, green: 184/255, blue: 72/255, alpha: 1.0)
        cell.detailTextLabel?.textColor = UIColor(red: 142/255, green: 184/255, blue: 72/255, alpha: 1.0)
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        //cell spacing
        cell.contentView.backgroundColor = UIColor.clear
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0,y: 10,width: self.view.frame.size.width,height: 80))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1,height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if makeMeal {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if makeMeal {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    /*
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        debugPrint("Segue:", segue.identifier as Any)
        if !makeMeal {
            if segue.identifier == "showDetail" {
                debugPrint("Segue after if: ", segue.identifier as Any)
                if let indexPath = tableView.indexPathForSelectedRow {
                    debugPrint(indexPath)
                    var recipe: Recipe// = Recipe(category: "nah", name: "nope")
                    if searchController.isActive && searchController.searchBar.text != "" {
                        recipe = filteredRecipes[indexPath.row]
                    } else {
                        recipe = recipes[indexPath.row]
                    }
                    
                    let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                    debugPrint(controller)
                    debugPrint("Before pass to detail view",recipes[indexPath.row].name)
                    controller.detailItem = recipe
                    debugPrint("After pass to detail view",recipes[indexPath.row].name)
                    controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
            }
        }
    }
 */
}

extension MasterViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
}
