//
//  ContainerViewController+Actions.swift
//  Cities
//
//  Created by Jesus Barragan  on 25/01/25.
//

import UIKit
import Foundation
import PhotosUI
import MediaPlayer

extension ContainerViewController {
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if imageReplaceButtonTapped {
            firstApperanceArray.removeAll(where: {$0.isSelected})
            collectionView.reloadData()
        }else {
            let array = cities.filter({$0.isSelected})
            for image in array {
                var name = image.imageName + ".png"
                myImageClass.removeSavedImage(imageName: name)

            }
            cities.removeAll(where: {$0.isSelected})
            collectionView.reloadData()
        }
        

    }
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        selectButton.isSelected = !selectButton.isSelected
        bottomView.alpha =  selectButton.isSelected ? 0 : 1.0
        selectButton.setTitle(selectButton.isSelected ? "Cancel" : "Select", for: .normal)
        if imageReplaceButtonTapped {
            firstApperanceArray.forEach{$0.isSelected = false}
        }else {
            cities.forEach{$0.isSelected = false}
        }

        collectionView.reloadData()
        
    }
    
    @objc func appCameToForeground() {
        print("app enters foreground")
        appInBgMode = false
    }
    
    @objc func appMovedToBackground() {
        print("app enters Background")
        appInBgMode = true
    }
    @objc func appWillResignActive() {
        print("app become active")
        appInBgMode = false
    }
    
    @objc func volumeChanged(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let volumeChangeType = userInfo["Reason"] as? String,
               volumeChangeType == "ExplicitVolumeChange", let sequenceNumber = userInfo["SequenceNumber"] as? Int {
                DispatchQueue.main.async {
                   
                }
            }
        }
    }
    
    @IBAction func imageReplaceWithAnimationButtonTapped(_ sender: Any) {
        animationWork(type: "tap")
    }
    
    @objc func systemVolumeDidChange(notification: NSNotification) {
        print("volume")
        if let userInfo = notification.userInfo {
            if let volumeChangeType = userInfo["Reason"] as? String,
               volumeChangeType == "ExplicitVolumeChange", let sequenceNumber = userInfo["SequenceNumber"] as? Int {
                if !self.appInBgMode {
                    print("VolumeDidChange")
                    DispatchQueue.main.async {
                        if self.isInProgress == false {
                            self.animationWork(type: "volume")
                            self.isInProgress = true
                        }
                        if self.isInProgress == true {
                            let seconds = 0.4
                            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                self.isInProgress = false
                            }
                        }
                    }
                }
                print("volumeChangeType",volumeChangeType)
            }
        }
    }
    
    @IBAction func addImageButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
