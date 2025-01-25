//
//  SettingViewController.swift
//  Cities
//
//  Created by Pankush Dhawan on 20/11/24.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func effectSetupButtonTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EffectsViewController") as! EffectsViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func forceUploadButtonTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ForceUploadViewController") as! ForceUploadViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gallerySetupButtonTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GallerySetupViewController") as! GallerySetupViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    

}
