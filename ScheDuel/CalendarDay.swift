//
//  CalendarDay.swift
//  ScheDuel
//
//  Created by Alexander Skladanek on 3/22/21.
//

import Foundation
import UIKit







    
class CalendarDay: UIViewController {
    private class PopUpWindowView: UIView {
      
        
        let popupView = UIView(frame: CGRect.zero)
        let popupButton = UIButton(frame: CGRect.zero)
        let txtField = UITextField(frame: CGRect(x: 0, y: 0, width: 500.00, height: 30.00));
        var selectedDate: String = ""
        var max: Int = 0
        weak var ref: CalendarDay?
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
            
            
            
            txtField.backgroundColor = UIColor.systemBackground
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
    
 
    
    init(reference: CalendarDay?) {
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
        viewWillLayoutSubviews()
        self.dismiss(animated: true, completion: nil)
    }
    
   

}
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddButton(_ sender: Any) {
        handleAddCheck()
    }
    @objc func handleAddCheck(){
        weak var firstViewController: CalendarDay? //pass instance to popUpWindow so we can call update()
        firstViewController = self
        var popUpWindow: PopUpWindow
        popUpWindow = PopUpWindow(reference: firstViewController )
        self.present(popUpWindow, animated: true, completion: nil)
    }
    
    @objc func handleInc(sender:UIButton){
        if(longTerms[sender.tag].curr<longTerms[sender.tag].max){
            longTerms[sender.tag].curr+=1;
        }
        
        
        
        
    }
    @objc func handleDec(sender:UIButton){
        if(longTerms[sender.tag].curr>0){
            longTerms[sender.tag].curr-=1;
        }
        
        
    }
    @objc func handleCheck(sender:UIButton){
        if(checkLists[sender.tag].completed){
            checkLists[sender.tag].completed=false
            
        }
        else{
            checkLists[sender.tag].completed=true
            
        }
        
        
    }
    
    
}
