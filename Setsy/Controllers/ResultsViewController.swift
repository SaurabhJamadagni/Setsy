//
//  ResultsViewController.swift
//  Setsy
//
//  Created by Saurabh on 31/05/22.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var untilEventLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var locationName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationLabel.text = locationName
    }
    
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
