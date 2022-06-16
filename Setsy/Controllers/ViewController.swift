//
//  ViewController.swift
//  Setsy
//
//  Created by Saurabh on 30/05/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, EventManagerDelegate {

    @IBOutlet weak var eventPicker: UIPickerView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var eventManager = EventManager()
    var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventPicker.dataSource = self
        eventPicker.delegate = self
        searchTextField.delegate = self
        eventManager.delegate = self
        
        searchTextField.borderStyle = UITextField.BorderStyle.roundedRect
        
    }
    
    @IBAction func fetchInformation(_ sender: UIButton) {
        eventManager.getCoordinates(locationName: self.city)
//        performSegue(withIdentifier: "showResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.locationName = self.city
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventManager.selectionOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventManager.selectionOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventManager.selectedOption = eventManager.selectionOptions[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        if let enteredCity = searchTextField.text {
            self.city = enteredCity
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter place here"
            return false
        }
    }
    
    func updateUI(eventModel: EventModel) {
        DispatchQueue.main.async {
//            self.eventImage.image = UIImage(systemName: eventModel.eventImage)
//            self.eventLabel.text = eventModel.eventName
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }

}

