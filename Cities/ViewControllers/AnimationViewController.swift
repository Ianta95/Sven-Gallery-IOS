//
//  AnimationViewController.swift
//  Cities
//
//  Created by Pankush Dhawan on 24/11/24.
//

import UIKit

class AnimationViewController: UIViewController {
    @IBOutlet weak var glitchRadioImage: UIImageView!
    @IBOutlet weak var dominoRadioImage: UIImageView!
    @IBOutlet weak var rippleChangeRadioImage: UIImageView!
    @IBOutlet weak var instantChangeRadioImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        switch UserDefaultHelper.selectedAnimationType {
           
        case "ripple" :
            glitchRadioImage.image = UIImage(systemName: "circle")
            dominoRadioImage.image = UIImage(systemName: "circle")
            rippleChangeRadioImage.image =  UIImage(systemName: "circle.fill")
            instantChangeRadioImage.image = UIImage(systemName: "circle")
        case "domino":
            glitchRadioImage.image = UIImage(systemName: "circle")
            dominoRadioImage.image =  UIImage(systemName: "circle.fill")
            rippleChangeRadioImage.image = UIImage(systemName: "circle")
            instantChangeRadioImage.image = UIImage(systemName: "circle")
        case "instant":
            glitchRadioImage.image = UIImage(systemName: "circle")
            dominoRadioImage.image = UIImage(systemName: "circle")
            rippleChangeRadioImage.image = UIImage(systemName: "circle")
            instantChangeRadioImage.image =  UIImage(systemName: "circle.fill")
        case "glitch":
            glitchRadioImage.image =  UIImage(systemName: "circle.fill")
            dominoRadioImage.image = UIImage(systemName: "circle")
            rippleChangeRadioImage.image = UIImage(systemName: "circle")
            instantChangeRadioImage.image = UIImage(systemName: "circle")
        default :
            glitchRadioImage.image = UIImage(systemName: "circle")
            dominoRadioImage.image = UIImage(systemName: "circle")
            rippleChangeRadioImage.image = UIImage(systemName: "circle")
            instantChangeRadioImage.image = UIImage(systemName: "circle")
        }

    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func glitchButtonTapped(_ sender: Any) {
        UserDefaultHelper.selectedAnimationType = "glitch"
        glitchRadioImage.image =  UIImage(systemName: "circle.fill")
        dominoRadioImage.image = UIImage(systemName: "circle")
        rippleChangeRadioImage.image = UIImage(systemName: "circle")
        instantChangeRadioImage.image = UIImage(systemName: "circle")
    }
    @IBAction func dominoButtonTapped(_ sender: Any) {
        UserDefaultHelper.selectedAnimationType = "domino"
        glitchRadioImage.image = UIImage(systemName: "circle")
        dominoRadioImage.image =  UIImage(systemName: "circle.fill")
        rippleChangeRadioImage.image = UIImage(systemName: "circle")
        instantChangeRadioImage.image = UIImage(systemName: "circle")
    }
    @IBAction func rippleButtonTapped(_ sender: Any) {
        UserDefaultHelper.selectedAnimationType = "ripple"
        glitchRadioImage.image = UIImage(systemName: "circle")
        dominoRadioImage.image = UIImage(systemName: "circle")
        rippleChangeRadioImage.image =  UIImage(systemName: "circle.fill")
        instantChangeRadioImage.image = UIImage(systemName: "circle")
    }
    
    @IBAction func instantButtonTapped(_ sender: Any) {
        UserDefaultHelper.selectedAnimationType = "instant"
        glitchRadioImage.image = UIImage(systemName: "circle")
        dominoRadioImage.image = UIImage(systemName: "circle")
        rippleChangeRadioImage.image = UIImage(systemName: "circle")
        instantChangeRadioImage.image =  UIImage(systemName: "circle.fill")
    }
    
   

}
