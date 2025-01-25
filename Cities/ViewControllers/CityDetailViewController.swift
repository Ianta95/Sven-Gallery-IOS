//
//  CityDetailViewController.swift
//  Cities
//
//  Created by Yasar on 30.01.2021.
//

import UIKit
import MediaPlayer

class CityDetailViewController: UIViewController {
    
    var city: City?
    //@IBOutlet weak var zoomableScrollView: ZoomableScrollView!
    @IBOutlet var cityImageView:UIImageView!
    var isInProgress = false
    var firstPicture: Bool = true
    var allPicture: Bool = true
    var normalPicture: Bool = true
    var imageReplaceButtonTapped:Bool = false
    var passData :[City] = []
    var row = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityImageView.image = city?.selectedImage
        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizerDown.direction = .left
        self.view.addGestureRecognizer(swipeGestureRecognizerDown)

        let swipeGestureRecognizerDown1 = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizerDown1.direction = .right
        self.view.addGestureRecognizer(swipeGestureRecognizerDown1)
        
        let swipeGestureRecognizerDown2 = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizerDown2.direction = .down
        self.view.addGestureRecognizer(swipeGestureRecognizerDown2)
        
        let swipeGestureRecognizerDown3 = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizerDown3.direction = .up
        self.view.addGestureRecognizer(swipeGestureRecognizerDown3)
        addObserver()
        //zoomableScrollView.display(image: city!.selectedImage)
        cityImageView.enableZoom()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let volumeView = MPVolumeView(frame: CGRect(x: 0, y: -10, width: 5, height: 5))
        volumeView.backgroundColor = UIColor.clear
        self.view.addSubview(volumeView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(systemVolumeDidChange),
                                               name: Notification.Name("SystemVolumeDidChange"),
                                               object: nil)
    }
                                               
    
    @objc func systemVolumeDidChange(notification: NSNotification) {
        print("volume")
        if let userInfo = notification.userInfo {
            if let volumeChangeType = userInfo["Reason"] as? String,
               volumeChangeType == "ExplicitVolumeChange", let sequenceNumber = userInfo["SequenceNumber"] as? Int {
                DispatchQueue.main.async {
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
    
    func firstPictureApperationAnimation(completion: @escaping (() -> Void)) {
        var selectedOption = getUserDefault(valueForKay: .selectedImageBoxForForceUpload1)

        if UserDefaultHelper.pictureApperation == "firstPictureApperation"  {
            if let seconds = UserDefaultHelper.changePictureDelay1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    if let image = self.getImage(name: selectedOption ) {
                        self.cityImageView.image = image.selectedImage
                        //self.zoomableScrollView.display(image: image.selectedImage)

                        }
                    completion()
                }
            }else {
               
                    if let image = self.getImage(name: selectedOption) {
                        self.cityImageView.image = image.selectedImage
                        //zoomableScrollView.display(image: image.selectedImage)

                    }
                
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
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        print("dismisssss")
        if sender.direction == .right {
            row = row - 1
            if  row < passData.count && row >= 0 {
                cityImageView.image = passData[row].selectedImage
                //zoomableScrollView.display(image: passData[row].selectedImage)

            }
        }else if sender.direction == .left {
            row = row + 1
            if row < passData.count && row >= 0 {
                cityImageView.image = passData[row].selectedImage
                //zoomableScrollView.display(image: passData[row].selectedImage)

            }
        }else {
            self.dismiss(animated: true)
        }
    }
    
    func allPictureApperation(completion: @escaping (() -> Void)){
        var selectedOption = getUserDefault(valueForKay: .selectedImageBoxForForceUpload1)
        
        if UserDefaultHelper.allpictureApperation == "AllPictureApperation" {
            
            if let seconds = UserDefaultHelper.changePictureDelay2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    if let image = self.getImage(name: selectedOption){
                        self.cityImageView.image = image.selectedImage
                        //self.zoomableScrollView.display(image: image.selectedImage)

                        completion()
                    }
                }
                // self.collectionView.scrollToItem(at: IndexPath(item: allApperanceArray.count - 1, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
               
            }
            else {
                //collectionView.scrollToItem(at: IndexPath(item: allApperanceArray.count - 1, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
                
                if let image = self.getImage(name: selectedOption) {
                    self.cityImageView.image = image.selectedImage
                    //zoomableScrollView.display(image: image.selectedImage)

                }
                
                completion()
                
            }
        }
    }
    
    func getUserDefault(valueForKay key: Defaults)-> String {
        return UserDefaults.standard.value(forKey: key.rawValue) as? String ?? ""

    }
    
    func backToNormal(completion: @escaping (() -> Void)) {
        if UserDefaultHelper.backtoApperation == "BackToNormal" {
            if let seconds = UserDefaultHelper.changePictureDelay3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[weak self] in
                    //self.collectionView.scrollToItem(at: IndexPath(item: cities.count - 1, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
                    self?.cityImageView.image = self?.city?.selectedImage
                   // self?.zoomableScrollView.display(image: (self?.city!.selectedImage)!)

                    completion()
                }
            }else {
                self.cityImageView.image = self.city?.selectedImage
                //zoomableScrollView.display(image: self.city!.selectedImage)
                completion()
                
            }
        }
    }
    
    

    
    @IBAction func crossButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}



extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
      
      
      
  }
}
