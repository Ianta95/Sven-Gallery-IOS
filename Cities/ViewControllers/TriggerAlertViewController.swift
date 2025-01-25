//
//  TriggerAlertViewController.swift
//  Cities
//
//  Created by Pankush Dhawan on 27/11/24.
//

import UIKit
protocol TriggerDelegate {
    func triggerButton(type:String, tap:String)
}

class TriggerAlertViewController: UIViewController {

    @IBOutlet weak var tapButton: UIButton!
    
    @IBOutlet weak var volumeButton: UIButton!
    var delegate: TriggerDelegate?
    var tap:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapButtonTapped(_ sender: Any) {
        //UserDefaultHelper.tapTrigger = "tap"
        //UserDefaultHelper.tapTrigger = ""
        tapButton.isSelected = true
        volumeButton.isSelected = false
        delegate?.triggerButton(type: "tap", tap: tap)
      
    }
    
    @IBAction func vibrateButtonTapped(_ sender: Any) {
        tapButton.isSelected = false
        volumeButton.isSelected = false
       
    }
    
    @IBAction func volumeButtonTapped(_ sender: Any) {
      
        delegate?.triggerButton(type: "volume", tap: tap)

        tapButton.isSelected = false
        volumeButton.isSelected = true
      
    }
    
    @IBAction func proximityButtonTapped(_ sender: Any) {
        tapButton.isSelected = false
        volumeButton.isSelected = false
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
