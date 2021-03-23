//
//  Home.swift
//  ScheDuel
//
//  Created by Alexander Skladanek on 3/18/21.
//

import UIKit
var reminderList: [reminder] = []
var eventList: [calEvent] = []
//Uninitialized global variables to access the list of each major object holder.

class reminder { //object class to be stored
    var text = "" //title
    var time = "" //time will be handled on a 0000-2359 basis
    var date = "" //handled on a 1-365 basis
    var repeating = 0 //0 means not, 1 is hourly, 2 daily, 3 weekly, 4 monthly, 5 yearly
    init(text: String, time: String, date: String){
        self.text = text
        self.time = time
        self.date = date
        self.repeating = 0
    }
}

class calEvent{ //object class to be stored
    var text = "" //title
    var time = "" //time will be handled on a 0000-2359 basis
    var duration = "" //in minutes
    var date = "" //handled on a 1-365 basis
    var repeating = 0 //0 means not, 1 is hourly, 2 daily, 3 weekly, 4 monthly, 5 yearly
    var color = 0 //for distinguishing which "calander" to put under
    var notes = "" //extra written details
    init(text: String, time: String, duration: String, date: String){
        self.text = text
        self.time = time
        self.duration = duration
        self.date = date
        self.repeating = 0
        self.color = 0
        self.notes = ""
    }
}

class UICustomObject {
    //Custom class for housing any UI elements I want in my vert stack
    var UIElement = 0 //0 for label, 1 for bar, 2 for event, 3 for reminder, 4 for title
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

class Home: UIViewController {
    override func viewDidLoad() {
        print("passed1")
        super.viewDidLoad()
    }
}

