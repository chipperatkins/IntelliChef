//
//  MasterViewController.swift
//  IntelliChef
//
//  Created by Joey Murphy on 2/3/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import UIKit
import Foundation

class MasterViewController: UITableViewController {
    
    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    var detailViewController: DetailViewController? = nil
    var recipes = [Recipe]()
    var filteredRecipes = [Recipe]()
    var addedRecipes = [Recipe]()
    
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.searchBarStyle = UISearchBarStyle(rawValue: 2)!
        self.tableView.allowsMultipleSelection = true
        
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            let controllersMeal = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
            detailViewController = (controllersMeal[controllersMeal.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://10.10.224.115:80/getRecipeList.php")!
        
        let task = session.dataTask(with: url, completionHandler:
            {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String: Any]]
                    {
                        
                        print(json)
                        for i in 0..<json.count {
                            print(json[i])
                            self.recipes.append(Recipe(id: json[i]["recipeID"] as! String, name: json[i]["name"] as! String, prep: (prep: json[i]["prepEst"] as! String) + " minutes", cook: (cook: json[i]["cookEst"] as! String) + " minutes"))
                        }
                        
                        DispatchQueue.main.sync(execute: {
                            self.tableView.reloadData()
                        })
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })
        task.resume()
        
        recipes = [
            Recipe(id: "aaaa", name: "Spaghetti", prep:"10", cook:"10"),
            Recipe(id: "bbbb", name: "Garlic Bread", prep:"15", cook:"10"),
            Recipe(id: "cccc", name: "Tiramisu", prep:"10", cook:"10"),
            Recipe(id: "dddd", name: "Mac & Cheese", prep:"14", cook:"11"),
            Recipe(id: "eeee", name: "Bread Pudding", prep:"10", cook:"10"),
            Recipe(id: "ffff", name: "Potato Salad", prep:"5", cook:"12"),
            Recipe(id: "gggg", name: "Cole Slaw", prep:"10", cook:"43"),
            Recipe(id: "hhhh", name: "Apple Pie", prep:"10", cook:"23"),
            Recipe(id: "iiii", name: "Pumpkin Pie", prep: "0", cook:"5"),
            Recipe(id: "jjjj", name: "Ice Cream Sundae", prep:"10", cook:"20"),
            Recipe(id: "kkkk", name: "Ceaser Salad", prep:"16", cook:"15"),
         ]
    }
    
    // modify the request as necessary, if necessary
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
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
        self.tableView.backgroundColor = UIColor(red: 25/255, green: 62/255, blue: 78/255, alpha: 1.0) /* #193e4e */
        // Custom Cell Formatting
        cell.backgroundColor = UIColor(red: 142/255, green: 184/255, blue: 72/255, alpha: 1.0) /* #8eb848 */
        cell.layer.cornerRadius = 7
        cell.textLabel?.textColor =  UIColor(red: 142/255, green: 184/255, blue: 72/255, alpha: 1.0) /* #8eb848 */
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
        debugPrint("didSelectRowAt called")
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if searchController.isActive && searchController.searchBar.text != "" {
            addedRecipes.append(filteredRecipes[indexPath.row])
            debugPrint("filtered recipe added", addedRecipes.count)
        } else {
            addedRecipes.append(recipes[indexPath.row])
            debugPrint("recipe added", addedRecipes.count)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        debugPrint("didDeselectRowAt called")
        var d = -1
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        if searchController.isActive && searchController.searchBar.text != "" {
            if addedRecipes.contains(where: { (recipe) -> Bool in
                if recipe.id == filteredRecipes[indexPath.row].id {
                    d = indexPath.row
                    return true
                } else {
                    return false
                }
            }) == true && d != -1 {
                addedRecipes.remove(at: d)
                debugPrint("filtered item removed")
            } else {
                debugPrint("no filtered recipe removed")
            }
        } else {
            if addedRecipes.contains(where: { (recipe) -> Bool in
                if recipe.id == recipes[indexPath.row].id {
                    d = indexPath.row
                    return true
                } else {
                    return false
                }
            }) == true && d != -1{
                debugPrint("recipe removed")
                if addedRecipes.count > 0 {
                    addedRecipes.remove(at: d)
                }
            } else {
                debugPrint("no recipe removed")
            }
            
        }
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        debugPrint("Segue:", segue.identifier as Any)
        if segue.identifier == "showDetail" {
            debugPrint("Segue not nil")
            if let indexPath = tableView.indexPathForSelectedRow {
                debugPrint(indexPath)
                //var recipe: Recipe// = Recipe(category: "nah", name: "nope")
                if searchController.isActive && searchController.searchBar.text != "" {
                    addedRecipes.append(filteredRecipes[indexPath.row])
                } else {
                    addedRecipes.append(recipes[indexPath.row])
                }
                
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                debugPrint("Master add array")
                controller.detailArray = addedRecipes
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else {
            if segue.identifier == "beginMeal" {
                debugPrint("Segue not nil")
                let controllerMeal = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                for recipe in addedRecipes {
                    debugPrint("Recipe",recipe)
                }
                controllerMeal.detailArray = addedRecipes
                controllerMeal.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controllerMeal.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        
    }
}

extension MasterViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
}
