//
//  DetailViewController.swift
//  IntelliChef
//
//  Created by Joey Murphy on 2/3/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var summary: UILabel?
    @IBOutlet weak var detailLabel: UILabel?
    @IBOutlet weak var prep: UILabel?
    @IBOutlet weak var cook: UILabel?
    
    var detailArray: [Recipe]? {
        didSet {
            configureMealView()
        }
    }
 
    func configureMealView() {
        debugPrint("Detail: configureMealView()",detailArray![0].summary)
        let multiSummary = "" as NSMutableString
        if (detailArray?.count)! > 1 {
            for detail in detailArray! {
                multiSummary.append(detail.name)
                multiSummary.append("\n")
            }
        }
        for detail in detailArray! {
            debugPrint("Detail Array", detail.name as Any)
            //self.navigationItem.title = detail.name
            detailLabel?.text = detail.name
            debugPrint("Summary.text", summary?.text as Any)
            summary?.text = detail.summary
            prep?.text = "Prep time\n" + detail.prepTime
            cook?.text = "Cook Time\n" + detail.cookTime
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let id = self.detailArray?[0].id
        let url = URL(string: ("http://10.10.224.115:80/getRecipe.php?id='"+id!+"'"))!
        
        let task = session.dataTask(with: url, completionHandler:
            {
                (data, response, error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                    
                } else {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String: Any]]
                        {
                            DispatchQueue.main.sync(execute: {
                                self.detailArray?[0].summary = json[0]["text"]! as! String
                                self.configureMealView()
                                self.summary?.text = self.detailArray?[0].summary
                            })
                        }
                        
                    } catch {
                        
                        print("error in JSONSerialization")
                        
                    }
                    
                    
                }
                
        })
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

