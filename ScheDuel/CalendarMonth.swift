//
//  CalendarSafe.swift
//  ScheDuel
//
//  Created by Alexander Skladanek on 3/22/21.
//

import Foundation
import UIKit

class CalendarMonth: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews(){
        //https://kevindew.me/post/18579273258/where-to-progmatically-lay-out-views-in-ios-5-and
        clearView()
        update()
        //clearview needs to  be called twice becauase of multithreading
    }
    @objc func clearView(){
        var i = 0
        while (i < self.view.subviews.count) {
            self.view.willRemoveSubview(self.view.subviews[i])
            self.view.subviews[i].removeFromSuperview()
            i = i + 1;
        }
    }
    @objc func update(){
        clearView()
        
        
    }
}
