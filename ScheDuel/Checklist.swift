//
//  Checklist.swift
//  ScheDuel
//
//  Created by Alexander Skladanek on 3/18/21.
//

import UIKit

var checkLists: [check] = []
var longTerms: [goal] = []


class check{
    var text = ""
    var time = ""
    var completed = false
    
    init(text: String, time: String, completed: Bool){
        self.text = text
        self.time = time
        self.completed = completed
    }
    
}
class goal{
    var text = ""
    var curr = 0  //number of compeleted entries
    var max = 0   //max number of entries 
    init(text: String, curr: Int, max: Int){
        self.text = text
        self.curr = curr
        self.max = max
    }
}

class Checklist: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    class UICustomObject {
        //Custom class for housing any UI elements I want in my vert stack
        var UIElement = 0 //0 for label, 1 for bar, 2 for check, 3 for goal, 4 for title
        var text = "" //text to be displayed
        var objPos = 0 //for reminders and events, position in global array
        init(element: Int){
            self.UIElement = element
            self.text = ""
            self.objPos = 0
        }
        init(element: Int, text: String){
            self.UIElement = element
            self.text = text
            self.objPos = 0
        }
        init(element: Int, text: String, pos: Int){
            self.UIElement = element
            self.text = text
            self.objPos = pos
        }
    }
    
    
    
    class Checklist: UIViewController {
        override func viewDidLoad() {
            print("passed1")
            super.viewDidLoad()
        }
    }
    
}

    

    


