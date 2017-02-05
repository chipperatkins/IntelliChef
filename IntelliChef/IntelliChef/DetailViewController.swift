//
//  DetailViewController.swift
//  IntelliChef
//
//  Created by Joey Murphy on 2/3/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var prep: UILabel!
    @IBOutlet weak var cook: UILabel!
    
    
    var detailItem: Recipe? {
        didSet {
            configureView()
        }
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

