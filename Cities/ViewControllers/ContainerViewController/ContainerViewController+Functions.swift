//
//  ContainerViewController+Functions.swift
//  Cities
//
//  Created by Jesus Barragan  on 25/01/25.
//

import UIKit
import Foundation
import PhotosUI
import MediaPlayer

extension ContainerViewController {
    
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(systemVolumeDidChange),
                                               name: Notification.Name("SystemVolumeDidChange"),
                                               object: nil)
        let notificationCenter = NotificationCenter.default
          notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
    }
       
   
    

    
    func setGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.view.layer.frame
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    func listenVolumeButton() {
       do {
        try audioSession.setActive(true)
       } catch {
        print("some error")
       }
       audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
    }


    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
      if keyPath == "outputVolume" {
        print("Hello")
          animationWork(type: "volume")
      }
    }
    
   
    
    func firstPictureApperationAnimation(completion: @escaping (() -> Void)) {
        var selectedOption = getUserDefault(valueForKay: .selectedImageBoxForForceUpload1)

        if UserDefaultHelper.pictureApperation == "firstPictureApperation"  {
            if let seconds = UserDefaultHelper.changePictureDelay1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    if let image = self.getImage(name: selectedOption ) {
                            firstApperanceArray.removeAll()
                            for  i in 0..<cities.count {
                                let cityImage = cities[i]
                                if i == cities.count - 1 {
                                    firstApperanceArray.append(image)
                                }else {
                                    firstApperanceArray.append(cityImage)
                                }
                            }
                            self.imageReplaceButtonTapped = true

                        }
                    
                    //self.collectionView.scrollToItem(at: IndexPath(item: firstApperanceArray.count - 1, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
                    self.collectionView.reloadData()
                    completion()
                }
            }else {
               
                    if let image = self.getImage(name: selectedOption) {
                        firstApperanceArray.removeAll()

                        for  i in 0..<cities.count {
                            let cityImage = cities[i]
                            if i == cities.count - 1 {
                                firstApperanceArray.append(image)
                            }else {
                                firstApperanceArray.append(cityImage)
                            }
                        }
                        self.imageReplaceButtonTapped = true
                    }
                
                //collectionView.scrollToItem(at: IndexPath(item: firstApperanceArray.count - 1, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
                self.collectionView.reloadData()
                completion()


            }
        }
    }
    
    func getImage(name:String) -> City?{
        let myImageClass = MyImageClass()
        let images = myImageClass.loadImageFromDocumentDirectory(folderName: MyImageClass.ForceUploadFolder,pictureName: name)
        if images.count > 0 {
            return images.first
        }
        return nil
    }
    
    func getUserDefault(valueForKay key: Defaults)-> String {
        return UserDefaults.standard.value(forKey: key.rawValue) as? String ?? ""

    }
    
    func allPictureApperation(completion: @escaping (() -> Void)){
        var selectedOption = getUserDefault(valueForKay: .selectedImageBoxForForceUpload1)
        
        if UserDefaultHelper.allpictureApperation == "AllPictureApperation" {
            
            if let seconds = UserDefaultHelper.changePictureDelay2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    if let image = self.getImage(name: selectedOption){
                        firstApperanceArray.removeAll()
                        for  _ in 0..<cities.count {
                            firstApperanceArray.append(City(selectedImage: image.selectedImage, imageName: image.imageName))
                        }
                        self.imageReplaceButtonTapped = true
                        self.collectionView.reloadData()
                        completion()
                    }
                }
                // self.collectionView.scrollToItem(at: IndexPath(item: allApperanceArray.count - 1, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
               
            }
            else {
                //collectionView.scrollToItem(at: IndexPath(item: allApperanceArray.count - 1, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
                
                if let image = self.getImage(name: selectedOption) {
                    firstApperanceArray.removeAll()
                    for  _ in 0..<cities.count {
                        firstApperanceArray.append(City(selectedImage: image.selectedImage, imageName: image.imageName))
                    }
                    self.imageReplaceButtonTapped = true
                    
                }
                
                // self.collectionView.scrollToItem(at: IndexPath(item: allApperanceArray.count - 1, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
                self.collectionView.reloadData()
                completion()
                
            }
        }
    }
    
    func backToNormal(completion: @escaping (() -> Void)) {
        if UserDefaultHelper.backtoApperation == "BackToNormal" {
            if let seconds = UserDefaultHelper.changePictureDelay3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    //self.collectionView.scrollToItem(at: IndexPath(item: cities.count - 1, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
                    self.collectionView.reloadData()
                    completion()
                }
            }else {
                // collectionView.scrollToItem(at: IndexPath(item: cities.count - 1, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
                self.collectionView.reloadData()
                completion()
                
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollingFinished(scrollView: scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            //didEndDecelerating will be called for sure
            return
        }
        scrollingFinished(scrollView: scrollView)
    }

    func scrollingFinished(scrollView: UIScrollView) {
       // Your code

    }
    
    func animationWork(type:String) {
        if UserDefaultHelper.tapTrigger1 == nil {
            UserDefaultHelper.tapTrigger1 = "tap"
        }
        if UserDefaultHelper.tapTrigger2 == nil {
            UserDefaultHelper.tapTrigger2 = "tap"
        }
        if UserDefaultHelper.tapTrigger3 == nil {
            UserDefaultHelper.tapTrigger3 = "tap"
        }
        if UserDefaultHelper.pictureApperation == "firstPictureApperation" && firstPicture &&  UserDefaultHelper.tapTrigger1 == type {
            firstPictureApperationAnimation {
                self.firstPicture = false
            }
        }else if UserDefaultHelper.allpictureApperation == "AllPictureApperation" && allPicture && UserDefaultHelper.tapTrigger2 == type{
            allPictureApperation {
                self.allPicture = false

            }
            
        } else if UserDefaultHelper.backtoApperation == "BackToNormal" && normalPicture && UserDefaultHelper.tapTrigger3 == type  {
            imageReplaceButtonTapped = false
            backToNormal {
                self.firstPicture = true
                self.allPicture = true

            }
        }
    }
    
    
    func createSnapshotAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            guard let imageG = self.view.createSnapshot() else { return }
            self.createGlitch(image: imageG, bounds: self.view.bounds)
        })
    }
    
}

extension UIView {
    // Animation snapshot
    func createSnapshot() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { layer.render(in: $0.cgContext) }
    }
}

extension UIImage {
    func getSplitedImage() -> [UIImage] {
        let imageSize = size
        print(imageSize)
        return []
    }
}
