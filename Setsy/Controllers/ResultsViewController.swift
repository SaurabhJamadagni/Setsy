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
    @IBOutlet weak var eventImage: UIImageView!
    
    var eventManager = EventManager()
    var locationName: String?
    var event: EventModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        eventManager.delegate = self
        
        locationLabel.text = self.locationName
    }
    
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
//    func updateUI(eventModel: EventModel) {
//        DispatchQueue.main.async {
//            self.eventImage.image = UIImage(systemName: eventModel.eventImage)
//            self.eventLabel.text = eventModel.eventName
//        }
//    }
//
//    func didFailWithError(error: Error) {
//        print(error)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
