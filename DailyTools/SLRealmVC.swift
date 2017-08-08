//
//  SLRealmVC.swift
//  DailyTools
//
//  Created by 林喜 on 7/28/17.
//  Copyright © 2017 ShowLin. All rights reserved.
//

import UIKit

class SLRealmVC: UIViewController {

    public var  vcTitle:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = vcTitle;
self.view.backgroundColor = UIColor.white
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
