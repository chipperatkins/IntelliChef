//
//  PageContentViewController.swift
//  IntelliChef
//
//  Created by Patrick Atkins on 2/4/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

 
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var pageIndex: Int = 0
    
    var strTitle: String!
    var strPhotoName: String!
    
    
    @IBAction func buttonPress(_ sender: UIButton) {
        
        

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = strTitle
        image.image = UIImage(named: strPhotoName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
