//
//  SLScrollLayoutVC.swift
//  DailyTools
//
//  Created by 林喜 on 7/24/17.
//  Copyright © 2017 ShowLin. All rights reserved.
//

import UIKit

class SLScrollLayoutVC: UIViewController {
    public var vcTitle:String = ""

    @IBOutlet weak var contentTH: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
self.title = vcTitle
        
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
