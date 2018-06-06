//
//  SLExtention.swift
//  DailyTools
//
//  Created by 林喜 on 8/8/17.
//  Copyright © 2017 ShowLin. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController{
   
}

extension UIViewController{
    func vcTitle(title:String) -> Void {
    self.title = title
    }
}
extension String{
    
}

extension UIDevice{
    public func isiphoneX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true;
        }
        return false;
        
    }
}
