//
//  HomeSafe.swift
//  ScheDuel
//
//  Created by Alexander Skladanek on 3/18/21.
//

import UIKit

class HomeSafe: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = true
        update()
    }
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
        let defaultCalEventUI = UICustomObject(element: 2, text: defaultReminder.text, pos: 0)
        containerStack.append(defaultCalEventUI)
        //Everything above is adding elements to my array for my vertical stack
        //Now i will turn them into real objects and display them!
        let height = self.view.bounds.height
        //These values are incorrect, not sure why
        let width = self.view.frame.width
        
        
        let elements = containerStack.count
        let seperation = height / CGFloat(elements)
        let fullFrame = CGRect(x: 0, y: 0, width: width, height: seperation)
        var i = 0
        //Remove all previous subviews
        while (i < containerStack.count){
            switch (containerStack[i].UIElement){
            case 0://label
                let label = UILabel()
                label.frame = fullFrame
                label.frame.origin.y += (CGFloat(i) * seperation)
                label.text = containerStack[i].text
                self.view.addSubview(label)
                break;
            case 1://bar
                let bar = UIProgressView(frame: fullFrame)
                bar.frame = fullFrame
                bar.frame.origin.y += (CGFloat(i) * seperation) + seperation/2.0
                bar.progress = 0
                //add time function later
                self.view.addSubview(bar)
                break;
            case 2://event
                let button = UIButton(frame: CGRect(x: 0, y: CGFloat(i) * seperation, width:(0.5 * seperation), height: seperation) )
                button.setImage( UIImage.init(systemName: "squareshape"), for: UIControl.State.normal)
                button.setImage( UIImage.init(systemName: "checkmark.square"), for: UIControl.State.highlighted)
                self.view.addSubview(button)
                let label = UILabel()
                label.frame = fullFrame
                label.frame.origin.y += (CGFloat(i) * seperation)
                label.frame.origin.x += seperation/2.0
                label.text = String(eventList[containerStack[i].objPos].time) + " " + eventList[containerStack[i].objPos].text
                self.view.addSubview(label)
                break;
            case 3://reminder
                let button = UIButton(frame: CGRect(x: 0, y: CGFloat(i) * seperation, width:(0.5 * seperation), height: seperation) )
                button.setImage( UIImage.init(systemName: "circle"), for: UIControl.State.normal)
                button.setImage( UIImage.init(systemName: "record.circle"), for: UIControl.State.highlighted)
                self.view.addSubview(button)
                let label = UILabel()
                label.frame = fullFrame
                label.frame.origin.y += (CGFloat(i) * seperation)
                label.frame.origin.x += seperation/2.0
                label.text = String(reminderList[containerStack[i].objPos].time) + " " + reminderList[containerStack[i].objPos].text
                self.view.addSubview(label)
                break;
            case 4://title
                let label = UILabel()
                label.frame = fullFrame
                label.frame.origin.y += (CGFloat(i) * seperation)
                label.text = containerStack[i].text
                label.font = label.font.withSize(CGFloat(label.font.pointSize + 2.0))
                label.textAlignment = NSTextAlignment.center
                self.view.addSubview(label)
                break;
            default://error?
                break;
            }
            i = i + 1
        }
    }
}
