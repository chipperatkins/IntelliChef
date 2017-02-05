//
//  DetailMealViewController.swift
//  IntelliChef
//
//  Created by Joey Murphy on 2/4/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//
/*
import UIKit

class DetailMealViewController: UIViewController {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var prep: UILabel!
    @IBOutlet weak var cook: UILabel!
    
    /*
    var detailItem: Recipe? {
        didSet {
            configureView()
        }
    }
    */
    var detailArray: [Recipe]? {
        didSet {
            configureMealView()
        }
    }
    /*
    func configureView() {
        debugPrint("Detail Item", detailItem?.name as Any)
        if let detail = detailItem {
            if let category = detailLabel {
                self.navigationItem.title = detail.name
                category.text = detail.name
                summary.text = detail.summary
                prep.text = "Prep time\n" + detail.prepTime
                cook.text = "Cook Time\n" + detail.cookTime
            }
        }
    }
    */
    func configureMealView() {
        debugPrint("Detail Meal: configureMealView()")
        for detail in detailArray! {
        debugPrint("Detail Array", detail.name as Any)
        //if let detail = detailItem {
          //  if let category = detailLabel {
                self.navigationItem.title = detail.name
                detailLabel.text = detail.name
                summary.text = detail.summary
                prep.text = "Prep time\n" + detail.prepTime
                cook.text = "Cook Time\n" + detail.cookTime
            }
       // }
       // }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMealView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
*/
