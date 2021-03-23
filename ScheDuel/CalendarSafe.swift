//
//  CalendarSafe.swift
//  ScheDuel
//
//  Created by Samuel on 3/22/21.
//

import UIKit
import FSCalendar

class CalendarSafe: UIViewController, FSCalendarDelegate {
    
    @IBOutlet var calendar: FSCalendar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.scrollDirection = .vertical
    }
    

    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("selected")
        calendar.scope = .week
        
        
    // When the user taps on a day, it takes them to a view that is populated with the current day's events,
    // and a button to add a new event
        
    }
    
    
}
