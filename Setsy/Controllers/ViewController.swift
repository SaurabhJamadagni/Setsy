//
//  ViewController.swift
//  Setsy
//
//  Created by Saurabh on 30/05/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var eventPicker: UIPickerView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var eventManager = EventManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventPicker.dataSource = self
        eventPicker.delegate = self
        
        searchTextField.borderStyle = UITextField.BorderStyle.roundedRect
        
    }
    
    @IBAction func fetchInformation(_ sender: UIButton) {
        performSegue(withIdentifier: "showResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let destinationVC = segue.destination as! ResultsViewController
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

}

