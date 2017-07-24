//
//  ViewController.swift
//  DailyTools
//
//  Created by 林喜 on 7/21/17.
//  Copyright © 2017 ShowLin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    var dataSource: NSMutableArray {
        get {
            let  datasource = NSMutableArray()
            datasource.addObjects(from: ["web页面","ScrolView的Autolayout约束"])
            return datasource
        }
        set {
            self.dataSource = newValue
        }
    }
    
    lazy var backView: UIView = {
        var backView:UIView = UIView()
        var rect:CGRect = self.view.frame
        rect.origin.y = 64;
        rect.size.height = 100;
        backView.frame = rect
        //计算当前时间
        let date:NSDate = NSDate.init()
        var calender = NSCalendar.current
        calender.firstWeekday = 2
        let weekDay = calender.component(.weekday, from: date  as Date)
        let year = calender.component(.year, from: date as Date)
        print(year)
        let weekOfYear = calender.component(.weekOfYear, from: date as Date)
        print(weekOfYear)
        
        
//        self.addNavTitle("\(year)第\(weekOfYear)周")
        let weekArray:[String] = ["周一","周二","周三","周四","周五","周六","周日"]
        var  count1 = 0
        
        for i in weekArray {
            var btn:UIButton = UIButton()
            btn.setTitle(i, for: UIControlState.normal)
        
           
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            var rect = CGRect(x:10+count1*49  ,y:5 ,width: 40, height: 40)
            btn.frame =  rect
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.layer.cornerRadius = 20
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.borderWidth = 1
            btn.layer.masksToBounds = true
            
            
            backView.addSubview(btn)
            
            var dateBtn:UIButton = UIButton(type:.custom)
            dateBtn.backgroundColor = UIColor.white
            dateBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
            var diffDay = 0
            if weekDay == 1{
                diffDay = 6
            }else{
                diffDay =  count1-weekDay+2
            }
            let todayDate = date.addingTimeInterval(TimeInterval(diffDay*24*60*60))
            let day = calender.component(.day, from: todayDate as Date)
            dateBtn.setTitle("\(day)", for: UIControlState.normal)
            if count1 == weekDay-2{
                dateBtn.backgroundColor = UIColor.orange
                dateBtn.layer.borderColor = UIColor.white.cgColor

            }else{
                dateBtn.backgroundColor = UIColor.white
                dateBtn.layer.borderColor = UIColor.lightGray.cgColor

            }
            rect.origin.y = 55
            rect.size.height = rect.size.width
            dateBtn.frame = rect
            backView.addSubview(dateBtn)
            dateBtn.layer.cornerRadius = rect.size.width/2
            dateBtn.layer.borderWidth = 1
            dateBtn.layer.masksToBounds = true
            dateBtn.tag = 100 + count1
            count1+=1
        }
        return backView
    }()
    
   lazy var tableview:UITableView = {
    var tableView:UITableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    var rect:CGRect = self.view.frame
    rect.origin.y = 180
    
    rect.size.height -= rect.origin.y
    tableView.frame = rect
    tableView.register(UITableViewCell().classForCoder , forCellReuseIdentifier: "cellId")
    return tableView
    
   }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.backView)
        self.view.addSubview(self.tableview)
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: UItableviewDelegate &&UITableviewDatasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellId"
        var cell: UITableViewCell;
        cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
//        cell.textLabel?.text = "第\(indexPath.row)行"
        cell.textLabel?.text = self.dataSource.object(at: indexPath.row) as? String
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let webVC:WebVC = self.storyboard!.instantiateViewController(withIdentifier: "WebVC") as! WebVC
            webVC.vcTitle = self.dataSource.object(at: indexPath.row )as? String
            webVC.hidesBottomBarWhenPushed = true
            self.navigationController!.pushViewController(webVC, animated: true)
        }else if indexPath.row == 1{
            let scrolVC:SLScrollLayoutVC = self.storyboard!.instantiateViewController(withIdentifier: "SLScrollLayoutVC") as!SLScrollLayoutVC
            scrolVC.hidesBottomBarWhenPushed = true
            scrolVC.title = self.dataSource.object(at: indexPath.row)as?String
            self.navigationController!.pushViewController(scrolVC, animated: true)
            print("点击了tableView的第二行")
        }
    }

}

