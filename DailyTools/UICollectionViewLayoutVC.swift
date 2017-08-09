//
//  UICollectionViewLayoutVC.swift
//  DailyTools
//
//  Created by 林喜 on 8/8/17.
//  Copyright © 2017 ShowLin. All rights reserved.
//

import UIKit

class UICollectionViewLayoutVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var datasource:NSMutableArray = ["左右滑动的图片布局"]
    

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //MARK:uitableviewDatasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
        cell.textLabel?.text = self.datasource.object(at: indexPath.row) as? String
        return  cell
        
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let horizonVC:SLhorizonColllectionVC = SLhorizonColllectionVC()
            horizonVC.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(horizonVC, animated: true)
            
            
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

extension UICollectionViewLayout{
    
    
    
}
