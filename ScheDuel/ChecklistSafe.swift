//
//  ChecklistSafe.swift
//  ScheDuel
//
//  Created by Allie Saari on 3/19/21.
//

import UIKit


extension UIView {
  func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}





class ChecklistSafe: UIViewController {
    
    
    private class PopUpWindowView: UIView {
      
        
        let popupView = UIView(frame: CGRect.zero)
        let popupButton = UIButton(frame: CGRect.zero)
        let txtField = UITextField(frame: CGRect(x: 0, y: 0, width: 500.00, height: 30.00));
        var selectedDate: String = ""
        var max: Int = 0
        weak var ref: ChecklistSafe?
        // let timePicker: UIDatePicker.Mode.time
        let timePicker: UIDatePicker = UIDatePicker()
  
        
        let BorderWidth: CGFloat = 1.5
        
        
        init() {

            super.init(frame: CGRect.zero)
    
            // Semi-transparent background
            backgroundColor = UIColor.black.withAlphaComponent(0.3)
            
          
           
            popupView.layer.borderWidth = BorderWidth
            popupView.layer.masksToBounds = true
            popupView.layer.borderColor = UIColor.systemBackground.cgColor
            popupView.backgroundColor = UIColor.gray
           

                txtField.placeholder = "Input To-Do Here"
                popupButton.setTitle("Add New To-Do", for: .normal)
                timePicker.datePickerMode = .time
                //timePicker.frame = CGRect(x: 10, y: 50, width: popupView.frame.width, height: 200)
                timePicker.timeZone = NSTimeZone.local
            timePicker.backgroundColor = UIColor.systemBackground
                timePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
                timePicker.translatesAutoresizingMaskIntoConstraints = false
            
               
                popupView.addSubview(timePicker)
  
            txtField.setCorner(radius: 5)
             popupView.setCorner(radius: 5)

            txtField.borderStyle = UITextField.BorderStyle.line
            
            
            
            txtField.backgroundColor = UIColor.white
            popupView.addSubview(txtField)

            
            
            // Popup Button
            popupButton.setTitleColor(UIColor.systemBackground, for: .normal)
            popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
            popupButton.backgroundColor = UIColor(red:0.25, green:0.37, blue:0.53, alpha:1)
        
            
         
            popupView.addSubview(popupButton)
            
            // Add the popupView(box) in the PopUpWindowView (semi-transparent background)
            addSubview(popupView)
            
            

       
            // PopupView constraints
            popupView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                popupView.widthAnchor.constraint(equalToConstant: 293),
                popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                ])
            
           NSLayoutConstraint.activate([
                timePicker.heightAnchor.constraint(greaterThanOrEqualToConstant: 67),
                timePicker.topAnchor.constraint(equalTo: txtField.bottomAnchor, constant: 8),
                timePicker.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15),
                timePicker.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
                timePicker.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8)
                 
                ])
            
            
            
            
    txtField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                txtField.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
                txtField.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
                txtField.topAnchor.constraint(equalTo: popupView.topAnchor, constant: BorderWidth),
                txtField.heightAnchor.constraint(equalToConstant: 55)
                ])
            
 
            // PopupButton constraints
            popupButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                popupButton.heightAnchor.constraint(equalToConstant: 44),
                popupButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
                popupButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
                popupButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -BorderWidth)
                ])
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        
        
        @objc func datePickerValueChanged(sender: UIDatePicker){
                
             
                let dateFormatter: DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                selectedDate = dateFormatter.string(from: sender.date)

            }
      
    
        

        
            
          
        
    }
    

class PopUpWindow: UIViewController {

    private  let popUpWindowView = PopUpWindowView()
    
 
    
    init(reference: ChecklistSafe?) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .popover
                
        popUpWindowView.ref = reference
       
        
       // popUpWindowView.popupButton.setTitle("Add New To-Do", for: .normal)
      
        popUpWindowView.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
      
        view = popUpWindowView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func dismissView() {
       
           // var callbackClosure: ((Void) -> Void)?
        let txt2 = ""
        if(popUpWindowView.txtField.text != ""){
            let newCheck = check(text: popUpWindowView.txtField.text ?? txt2, time: popUpWindowView.selectedDate, completed: false)
            checkLists.append(newCheck)
            if (popUpWindowView.selectedDate != ""){
                eventList.append(calEvent(text: popUpWindowView.txtField.text!, time: popUpWindowView.selectedDate, duration: "0", date: "0"))
            }
        }
        popUpWindowView.ref?.clearView()
        popUpWindowView.ref?.update()
        self.dismiss(animated: true, completion: nil)
    }
    
   

}
    
    
    
    
    private class PopUpWindowViewGoal: UIView {
        
        let popupView = UIView(frame: CGRect.zero)
        let popupButton = UIButton(frame: CGRect.zero)
        let txtField = UITextField(frame: CGRect(x: 0, y: 0, width: 500.00, height: 30.00));
        let numField = UITextField()
        var max: Int = 0
        weak var ref: ChecklistSafe?
        
        let BorderWidth: CGFloat = 2.0
        
        
        init() {

            super.init(frame: CGRect.zero)
    
            // Semi-transparent background
            backgroundColor = UIColor.black.withAlphaComponent(0.3)
            
          
            
            popupView.layer.borderWidth = BorderWidth
            popupView.layer.masksToBounds = true
            popupView.layer.borderColor = UIColor.white.cgColor
            popupView.setCorner(radius: 5)
            popupView.backgroundColor = UIColor.gray
          
       
  
            txtField.setCorner(radius: 5)
            txtField.placeholder = "Input Long Term Goal Here"
            popupButton.setTitle("Add New Long Term Goal", for: .normal)
            numField.keyboardType = .decimalPad
            numField.translatesAutoresizingMaskIntoConstraints = false
            numField.setCorner(radius: 5)
            numField.backgroundColor = UIColor.white
            popupView.addSubview(numField)

            
            
           
            txtField.borderStyle = UITextField.BorderStyle.line
            
            txtField.backgroundColor = UIColor.white
            numField.backgroundColor = UIColor.white
            numField.placeholder = "Input Number of Steps Here"
            numField.textColor = UIColor.gray
            txtField.textColor = UIColor.gray
            popupView.addSubview(txtField)

            
            
            // Popup Button
            popupButton.setTitleColor(UIColor.white, for: .normal)
            popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
            popupButton.backgroundColor = UIColor(red:0.25, green:0.37, blue:0.53, alpha:1) //
         
        
            
         
            popupView.addSubview(popupButton)
            
            // Add the popupView(box) in the PopUpWindowView (semi-transparent background)
            addSubview(popupView)
            
            
            // PopupView constraints
            popupView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                popupView.widthAnchor.constraint(equalToConstant: 293),
                popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                ])
            
            NSLayoutConstraint.activate([
                numField.heightAnchor.constraint(greaterThanOrEqualToConstant: 67),
                numField.topAnchor.constraint(equalTo: txtField.bottomAnchor, constant: 8),
                numField.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15),
                numField.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
                numField.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8)
                ])
            
            
            
            
    txtField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                txtField.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
                txtField.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
                txtField.topAnchor.constraint(equalTo: popupView.topAnchor, constant: BorderWidth),
                txtField.heightAnchor.constraint(equalToConstant: 55)
                ])

            // PopupButton constraints
            popupButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                popupButton.heightAnchor.constraint(equalToConstant: 44),
                popupButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
                popupButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
                popupButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -BorderWidth)
                ])
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    }
    

class PopUpWindowGoal: UIViewController {

    private  let popUpWindowViewGoal = PopUpWindowViewGoal()
    
 
    
    init(reference: ChecklistSafe?) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
         modalPresentationStyle = .overFullScreen
                
        popUpWindowViewGoal.ref = reference

      
        popUpWindowViewGoal.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
      
        view = popUpWindowViewGoal
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func dismissView() {
       
           // var callbackClosure: ((Void) -> Void)?
        let txt2 = ""
        let int = Int(popUpWindowViewGoal.numField.text ?? "") ?? 0
        if(popUpWindowViewGoal.txtField.text != ""){
        let newGoal = goal(text: popUpWindowViewGoal.txtField.text ?? txt2, curr: 0,  max: int )
        longTerms.append(newGoal)
        
        }
        popUpWindowViewGoal.ref?.clearView()
        popUpWindowViewGoal.ref?.update()
        self.dismiss(animated: true, completion: nil)
    }
    
   

}


    
    @objc func handleAddCheck(){
        weak var firstViewController: ChecklistSafe? //pass instance to popUpWindow so we can call update()
        firstViewController = self
        var popUpWindow: PopUpWindow
        popUpWindow = PopUpWindow(reference: firstViewController )
        self.present(popUpWindow, animated: true, completion: nil)
        clearView()


    }
    
    @objc func handleAddGoal(){
        
        weak var firstViewController: ChecklistSafe?
        firstViewController = self
        var popUpWindow: PopUpWindowGoal
        popUpWindow = PopUpWindowGoal( reference: firstViewController )
        self.present(popUpWindow, animated: true, completion: nil)
        clearView()
        
    }
    @objc func handleInc(sender:UIButton){
        if(longTerms[sender.tag].curr<longTerms[sender.tag].max){
            longTerms[sender.tag].curr+=1;
            clearView()
            update()
        }
        
        
        
        
    }
    @objc func handleDec(sender:UIButton){
        if(longTerms[sender.tag].curr>0){
            longTerms[sender.tag].curr-=1;
            clearView()
            update()
        }
        
        
    }
    @objc func handleCheck(sender:UIButton){
        if(checkLists[sender.tag].completed){
            checkLists[sender.tag].completed=false
            
        }
        else{
            checkLists[sender.tag].completed=true
            
        }
        clearView()
        update()
        
        
    }
    
    @objc func handleCheckGoal(sender:UIButton){ //-1 for completed, 0 for not
        if(longTerms[sender.tag].max == -1){
            longTerms[sender.tag].max = 0
            
        }
        else{
            longTerms[sender.tag].max = 0
            
        }
        clearView()
        update()
        
        
    }
    
   override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillLayoutSubviews(){
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
        var containerStack : [UICustomObject] = []
        //vertical stack for the checklist as an array of stuff
        let bar = UICustomObject(element: 1)
    
      //  containerStack.append(bar)
        let todayLabel = UICustomObject(element: 0)
        todayLabel.text = "Today: "
        containerStack.append(todayLabel)
        
    
        
        for i in 0..<checkLists.count{
            let checkUI = UICustomObject(element: 2, text: checkLists[i].text, pos: i)
            
            containerStack.append(checkUI)
        }
        
     
        containerStack.append(bar)
        let goalLabel = UICustomObject(element: 0)
        goalLabel.text = "Long Term Goals: "
        containerStack.append(goalLabel)
        
        
  
        
        for i in 0..<longTerms.count{
            let goalUI = UICustomObject(element: 3, text: longTerms[i].text, pos: i)
            
            containerStack.append(goalUI)
        }
    
        let height = CGFloat(400)
       
        let width = self.view.frame.width
        let elements = containerStack.count
        let seperation = height / CGFloat(elements)
        let fullFrame = CGRect(x: 0, y: 0, width: width, height: seperation)
        var i = 0
        //Remove all previous subviews
       
        while (i < containerStack.count){
            switch (containerStack[i].UIElement){
            
            case 0://  labels

                let label = UILabel()
                label.frame = fullFrame
                label.frame.origin.y += (CGFloat(i) * seperation)
                label.text = containerStack[i].text
                self.view.addSubview(label)
               
                
                if(label.text=="Today: "){
                    let button = UIButton(frame: CGRect(x: 200, y: CGFloat(i) * seperation, width:(0.5 * seperation), height: seperation))
               
                button.setImage( UIImage.init(systemName: "plus.circle"), for: UIControl.State.normal)
                button.setImage( UIImage.init(systemName: "plus.circle.fill"), for: UIControl.State.highlighted)
                button.addTarget(self, action:#selector(handleAddCheck), for: .touchUpInside)
                button.tintColor = UIColor(red:0.25, green:0.37, blue:0.53, alpha:1)
                    self.view.addSubview(button)
                }
                if(label.text=="Long Term Goals: "){
                    let button2 = UIButton(frame: CGRect(x: 200, y: CGFloat(i) * seperation, width:(0.5 * seperation), height: seperation))
                    button2.setImage( UIImage.init(systemName: "plus.circle"), for: UIControl.State.normal)
                    button2.setImage( UIImage.init(systemName: "plus.circle.fill"), for: UIControl.State.highlighted)
                    button2.addTarget(self, action:#selector(handleAddGoal), for: .touchUpInside)
                    button2.tintColor = UIColor(red:0.25, green:0.37, blue:0.53, alpha:1)
                    self.view.addSubview(button2)
                    
                }

                break;
            case 1: //bar
                let bar = UIProgressView(frame: fullFrame)
                bar.frame = fullFrame
               bar.frame.origin.y += (CGFloat(i) * seperation) + seperation/2.0
                bar.progress = 0
                bar.tintColor =  UIColor(red:0.25, green:0.37, blue:0.53, alpha:1)
        
                self.view.addSubview(bar)
                break;
                
            case 2://checklist
                let button = UIButton(frame: CGRect(x: 0, y: CGFloat(i) * seperation, width:(0.5 * seperation), height: seperation) )
                button.tintColor = UIColor(red:0.25, green:0.37, blue:0.53, alpha:1)
                if(checkLists[containerStack[i].objPos].completed){
                button.setImage( UIImage.init(systemName: "checkmark.square"), for: UIControl.State.normal)
                }
                else{
                    button.setImage( UIImage.init(systemName: "squareshape"), for: UIControl.State.normal)
                }
                
                button.tag = containerStack[i].objPos
                button.addTarget(self, action:#selector(handleCheck), for: .touchUpInside)
                
                self.view.addSubview(button)
                let label = UILabel()
                label.frame = fullFrame
                label.frame.origin.y += (CGFloat(i) * seperation)
                label.frame.origin.x += seperation/2.0
                
                label.text = String(checkLists[containerStack[i].objPos].time) + " " + checkLists[containerStack[i].objPos].text
                self.view.addSubview(label)
                break;
                
            case 3: //goal
                
               
                let label = UILabel()
                label.frame = fullFrame
                label.frame.origin.y = (CGFloat(i) * seperation)
        
                if(longTerms[containerStack[i].objPos].max==0 || longTerms[containerStack[i].objPos].max == -1){ //if there is no measurable
                    label.frame.origin.x += seperation/2.0
                    let button = UIButton(frame: CGRect(x: 0, y: CGFloat(i) * seperation, width:(0.5 * seperation), height: seperation) )
                    button.tintColor = UIColor(red:0.25, green:0.37, blue:0.53, alpha:1)
                    
                    if(longTerms[containerStack[i].objPos].max == -1){ //-1= completed
                    button.setImage( UIImage.init(systemName: "checkmark.square"), for: UIControl.State.normal)
                    }
                    else{
                        button.setImage( UIImage.init(systemName: "squareshape"), for: UIControl.State.normal)
                    }
                    
                    button.tag = containerStack[i].objPos
                    button.addTarget(self, action:#selector(handleCheckGoal), for: .touchUpInside)
                    self.view.addSubview(button)
                    label.text = longTerms[containerStack[i].objPos].text
                    
                }else{
                    label.frame.origin.x = 2.5*(UIImage.init(systemName: "minus.rectangle.fill")?.size.width)!
                    let plusButton = UIButton(frame: CGRect(x: 0, y: CGFloat(i) * seperation, width:(0.5 * seperation), height: seperation) )
                    plusButton.tintColor = UIColor(red:0.25, green:0.37, blue:0.53, alpha:1)
                    plusButton.setImage( UIImage.init(systemName: "plus.rectangle"), for: UIControl.State.normal)
                    plusButton.setImage( UIImage.init(systemName: "plus.rectangle.fill"), for: UIControl.State.highlighted)
                    plusButton.tag = containerStack[i].objPos //save for target function access
                    
                    let minusButton = UIButton(frame: CGRect(x:UIImage.init(systemName: "minus.rectangle.fill")?.size.width ?? 0.5*seperation, y: CGFloat(i) * seperation, width:(0.5 * seperation), height: seperation) )  // x coordinate may need working on
                    
                    minusButton.setImage( UIImage.init(systemName: "minus.rectangle"), for: UIControl.State.normal)
                    minusButton.setImage( UIImage.init(systemName: "minus.rectangle.fill"), for: UIControl.State.highlighted)
                    minusButton.tag = containerStack[i].objPos
                    minusButton.tintColor = UIColor(red:0.25, green:0.37, blue:0.53, alpha:1)
                    
                    
                    minusButton.addTarget(self, action:#selector(handleDec), for: .touchUpInside)
                    plusButton.addTarget(self, action:#selector(handleInc), for: .touchUpInside)
                    self.view.addSubview(plusButton)
                    self.view.addSubview(minusButton)
                    
                    label.text = String(longTerms[containerStack[i].objPos].curr) + "/" + String(longTerms[containerStack[i].objPos].max) + " " + longTerms[containerStack[i].objPos].text
                }
                self.view.addSubview(label)
                break;
                
                
            default://error?
                break;
            }
            i = i + 1
        }
        
       
    }
    
}
