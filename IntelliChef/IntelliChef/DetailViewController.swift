//
//  DetailViewController.swift
//  IntelliChef
//
//  Created by Joey Murphy on 2/3/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var candyImageView: UIImageView!
  
  var detailItem: Recipe? {
    didSet {
      configureView()
    }
  }
  
  func configureView() {
    if let detail = detailItem {
      if let label = detailDescriptionLabel {
        label.text = detail.category
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

