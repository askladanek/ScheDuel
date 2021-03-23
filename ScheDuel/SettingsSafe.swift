//
//  SettingsSafe.swift
//  ScheDuel
//
//  Created on 3/20/21.
//

import UIKit

class SettingsSafe: UIViewController, UIPopoverPresentationControllerDelegate, UITextViewDelegate{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var weatherButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var newsButton: UIButton!
    @IBOutlet var profPic : UIImageView!
    @IBOutlet weak var bioText: UITextView!
    var savedBio : String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showPopover" {
               let popoverViewController = segue.destination
               popoverViewController.modalPresentationStyle = .popover
               popoverViewController.presentationController?.delegate = self
               popoverViewController.popoverPresentationController?.sourceView = aboutButton
               popoverViewController.popoverPresentationController?.sourceRect  = CGRect(x: 0, y: 0, width: aboutButton.frame.size.width, height: aboutButton.frame.size.height)
           }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
           return UIModalPresentationStyle.none
    }
    
    @IBAction func addButtonTapped(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func weatherButtonTapped(){
        UIApplication.shared.open(URL(string: "https://weather.com/weather/today")!as URL, options:[:],
                                  completionHandler: nil)
    }
    
    @IBAction func mapButtonTapped(){
        UIApplication.shared.open(URL(string: "https://maps.google.com")!as URL, options:[:],
                                  completionHandler: nil)
    }
    
    @IBAction func newsButtonTapped(){
        UIApplication.shared.open(URL(string: "https://news.google.com")!as URL, options:[:],
                                  completionHandler: nil)
    }
    
    func textViewDidBeginEditing(bioText: UITextView){
        if bioText.textColor == UIColor.lightGray{
            bioText.text = nil
            bioText.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(bioText: UITextView){
        if bioText.text.isEmpty{
            bioText.text = "Add a bio..."
            bioText.textColor = UIColor.lightGray
        }
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      profPic.layer.cornerRadius = profPic.frame.height / 2.0
        aboutButton.layer.cornerRadius = 5
        weatherButton.layer.cornerRadius = 5
        mapButton.layer.cornerRadius = 5
        newsButton.layer.cornerRadius = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userName = UIDevice.current.name
        //let userName = NSFullUserName()
        nameLabel.text = userName
        bioText.text = "Add a bio..."
        bioText.textColor = UIColor.lightGray
        bioText.delegate = self
        self.bioText.addDoneButton(title:"Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    @objc func tapDone(sender: Any){
        self.view.endEditing(true)
        bioText.textColor = UIColor.black
    }


}

extension SettingsSafe: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            profPic.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
