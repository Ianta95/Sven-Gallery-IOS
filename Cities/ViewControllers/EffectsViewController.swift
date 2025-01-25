//
//  EffectsViewController.swift
//  Cities
//
//  Created by Pankush Dhawan on 23/11/24.
//

import UIKit

class EffectsViewController: UIViewController, TriggerDelegate {
    @IBOutlet weak var backToNormalSlider: UISlider!
    @IBOutlet weak var allPictureSlider: UISlider!
    @IBOutlet weak var firstPictureSwitch: UILabel!
    @IBOutlet weak var tap1: UIButton!
    @IBOutlet weak var tap2: UIButton!
    @IBOutlet weak var tap3: UIButton!

    @IBOutlet weak var allSwitch: UISwitch!
    @IBOutlet weak var firstSwitch: UISwitch!
    @IBOutlet weak var backToNormalDelayTextLabel: UILabel!
    @IBOutlet weak var allAnimationDelayTextLabel: UILabel!
    @IBOutlet weak var firstAnimationDelayTextLabel: UILabel!
    @IBOutlet weak var firstPictureSlider: UISlider!
    @IBOutlet weak var backToNormalSwitch: UISwitch!
    @IBOutlet weak var allPictureSwitch: UILabel!
    var isSelectedVolume1 = false
    var isSelectedVolume2 = false
    var isSelectedVolume3 = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if UserDefaultHelper.allpictureApperation == "AllPictureApperation" {
            allSwitch.isOn = true

        }
        if UserDefaultHelper.pictureApperation == "firstPictureApperation" {
            firstSwitch.isOn = true

        }
        if UserDefaultHelper.backtoApperation == "BackToNormal" {
            backToNormalSwitch.isOn = true

        }
        firstPictureSlider.value = 0
        allPictureSlider.value = 0
        backToNormalSlider.value = 0
        if firstSwitch.isOn {
            firstPictureSlider.value = Float(UserDefaultHelper.changePictureDelay1 ?? 0.0)
            let currentValue = Int(firstPictureSlider.value )
            firstAnimationDelayTextLabel.text = "ANIMATION DELAY (\(currentValue)s)"
        }
        
        if allSwitch.isOn {
            allPictureSlider.value = Float(UserDefaultHelper.changePictureDelay2 ?? 0.0)
            let currentValue = Int(allPictureSlider.value )
            allAnimationDelayTextLabel.text = "ANIMATION DELAY (\(currentValue)s)"
        }
        if backToNormalSwitch.isOn {
            backToNormalSlider.value = Float(UserDefaultHelper.changePictureDelay3 ?? 0.0)
            let currentValue = Int(backToNormalSlider.value )
            backToNormalDelayTextLabel.text = "ANIMATION DELAY (\(currentValue)s)"

        }
        if UserDefaultHelper.tapTrigger1 == "volume" {
            isSelectedVolume1 = true
        }
        if UserDefaultHelper.tapTrigger2 == "volume" {
            isSelectedVolume2 = true
        }
        if UserDefaultHelper.tapTrigger3 == "volume" {
            isSelectedVolume3 = true
        }
        tap1.setTitle(UserDefaultHelper.tapTrigger1 ?? "tap", for: .normal)
        tap2.setTitle(UserDefaultHelper.tapTrigger2 ?? "tap", for: .normal)
        tap3.setTitle(UserDefaultHelper.tapTrigger3 ?? "tap", for: .normal)
    }
    
    
    @IBAction func backToNormalButtonTaooed(_ sender: UIButton) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TriggerAlertViewController") as! TriggerAlertViewController
//        nextViewController.delegate = self
//        nextViewController.tap = "tap3"
//        self.present(nextViewController, animated: true)
        isSelectedVolume3 = !isSelectedVolume3
        triggerButton(type: isSelectedVolume3 ? "volume":"tap", tap: "tap3")
        //self.performSegue(withIdentifier: "presentscreen", sender: nil)

    }
    @IBAction func allPictureButtonTapped(_ sender: UIButton) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TriggerAlertViewController") as! TriggerAlertViewController
//        nextViewController.delegate = self
//        nextViewController.tap = "tap2"
//        self.present(nextViewController, animated: true)
        isSelectedVolume2 = !isSelectedVolume2
        triggerButton(type: isSelectedVolume2 ? "volume":"tap", tap: "tap2")
        //self.performSegue(withIdentifier: "presentscreen", sender: nil)

    }
    @IBAction func firstTapButtonTapped(_ sender: UIButton) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TriggerAlertViewController") as! TriggerAlertViewController
//        nextViewController.delegate = self
//        nextViewController.tap = "tap1"
//        self.present(nextViewController, animated: true)
        //self.performSegue(withIdentifier: "presentscreen", sender: nil)
        isSelectedVolume1 = !isSelectedVolume1
        triggerButton(type: isSelectedVolume1 ? "volume":"tap", tap: "tap1")
    }
    @IBAction func backToNormalSliderTapped(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        backToNormalDelayTextLabel.text = "ANIMATION DELAY (\(currentValue)s)"
        if backToNormalSwitch.isOn {

            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                UserDefaultHelper.changePictureDelay3 = Double(currentValue)

            }
            print(UserDefaultHelper.changePictureDelay3)
        }

    }
    
    func triggerButton(type: String, tap: String) {
        if tap == "tap1" {
            UserDefaultHelper.tapTrigger1 = type
            tap1.setTitle(type, for: .normal)
        }else if tap == "tap2" {
            UserDefaultHelper.tapTrigger2 = type
            tap2.setTitle(type, for: .normal)

        }else if tap == "tap3" {
            UserDefaultHelper.tapTrigger3 = type
            tap3.setTitle(type, for: .normal)

        }
    }
    
    @IBAction func allPictureSliderTapped(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        allAnimationDelayTextLabel.text = "ANIMATION DELAY (\(currentValue)s)"
        if allSwitch.isOn {
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                UserDefaultHelper.changePictureDelay2 = Double(currentValue)

            }

            print(UserDefaultHelper.changePictureDelay2)


        }
    }
    @IBAction func firstPictureSliderTapped(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        firstAnimationDelayTextLabel.text = "ANIMATION DELAY (\(currentValue)s)"
        if firstSwitch.isOn {
            let seconds = 1.0

            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                UserDefaultHelper.changePictureDelay1 = Double(currentValue)

                print(UserDefaultHelper.changePictureDelay1)

            }

        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func firstPictureSwitchTapped(sender: UISwitch) {
        if sender.isOn {
            UserDefaultHelper.pictureApperation = "firstPictureApperation"
        }else {
            UserDefaultHelper.pictureApperation = ""

        }

    }
    
    @IBAction func allPictureSwitchTapped(sender: UISwitch) {
        if sender.isOn {
            UserDefaultHelper.allpictureApperation = "AllPictureApperation"
        }else {
            UserDefaultHelper.allpictureApperation = ""

        }

    }
    
    @IBAction func backToTNormalSwitchTapped(sender: UISwitch) {
        if sender.isOn {
            UserDefaultHelper.backtoApperation = "BackToNormal"
        }else {
            UserDefaultHelper.backtoApperation = ""

        }
    }
    
    @IBAction func animationButtonTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AnimationViewController") as! AnimationViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func extendedButtonTapped(_ sender: Any) {
    }
}
