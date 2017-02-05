//
//  DetailViewController.swift
//  IntelliChef
//
//  Created by Joey Murphy on 2/3/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailLabel: UILabel?
    @IBOutlet weak var summary: UILabel?
    @IBOutlet weak var prep: UILabel?
    @IBOutlet weak var cook: UILabel?
    
    var detailArray: [Recipe]? {
        didSet {
            configureMealView()
        }
    }
 
    func configureMealView() {
        debugPrint("Detail: configureMealView()",detailArray as [Recipe]!)
        
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
        configureMealView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

