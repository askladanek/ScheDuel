//
//  HomeSafe.swift
//  ScheDuel
//
//  Created by Alexander Skladanek on 3/18/21.
//

import UIKit

class HomeSafe: UIViewController {
    @objc func update(){
        var containerStack : [UICustomObject] = []
        //Defining my own vertical stack for the home screen as an array of stuff
        let title = UICustomObject(element: 4)
        title.text = "Welcome Back!"
        containerStack.append(title) //0
        let bar = UICustomObject(element: 1)
        containerStack.append(bar) //1
        let remindersLabel = UICustomObject(element: 0)
        remindersLabel.text = "Reminders: "
        containerStack.append(remindersLabel)  //2
        let defaultReminder = reminder(text: "test", time: 0, date: 0)
        reminderList.append(defaultReminder)
        let defaultReminderUI = UICustomObject(element: 3, text: defaultReminder.text, pos: 0)
        containerStack.append(defaultReminderUI)
        //add reminders list to position 3
        containerStack.append(bar)
        let whatsNextLabel = UICustomObject(element: 0)//4+reminders
        whatsNextLabel.text = "What's Next: "
        containerStack.append(whatsNextLabel)//5+reminders
        let defaultCalEvent = calEvent(text: "test", time: 0, duration: 1, date: 0)
        eventList.append(defaultCalEvent)
        let defaultCalEventUI = UICustomObject(element: 3, text: defaultReminder.text, pos: 0)
        containerStack.append(defaultCalEventUI)
        //Everything above is adding elements to my array for my vertical stack
        //Now i will turn them into real objects and display them!
        let height = view.bounds.height
        let width = view.bounds.width
        let elements = containerStack.count
        let seperation = height / CGFloat(elements)
        var i = 0
        print("passed line 42")
        //Remove all previous subviews
        while (i < containerStack.count){
            switch (containerStack[i].UIElement){
            case 0://label
                let label = UILabel()
                label.frame = CGRect(x: 0, y: CGFloat(i) * seperation,width: width, height: 0.75*seperation)
                label.text = containerStack[i].text
                self.view.addSubview(label)
                print("added subview")
                break;
            case 1://bar
                let bar = UIProgressView(frame: CGRect(x: 0, y: CGFloat(i) * seperation,width: width, height: 0.75*seperation))
                bar.progress = 0
                //add time function later
                self.view.addSubview(bar)
                break;
            case 2://event
                //To be implemented
                break;
            case 3://reminder
                //To be implemented
                break;
            case 4://title
                let label = UILabel()
                label.frame = CGRect(x: 0, y: CGFloat(i) * seperation,width: width, height: 0.75*seperation)
                label.text = containerStack[i].text
                label.font = label.font.withSize(CGFloat(label.font.pointSize + 2.0))
                label.textAlignment = NSTextAlignment.center
                self.view.addSubview(label)
                print("added subview")
                break;
            default://error?
                break;
            }
            i = i + 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
}
