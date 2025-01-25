//
//  ContainerViewController.swift
//  Cities
//
//  Created by Pankush Dhawan on 16/11/24.
//

import UIKit
import Foundation
import PhotosUI
import MediaPlayer
 var cities : [City] = []
var firstApperanceArray :[City] = []
//var allApperanceArray :[City] = []


class ContainerViewController: UIViewController {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var changeImageButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var deleteButton: UIButton!
    var configuration = PHPickerConfiguration()
    var imageReplaceButtonTapped:Bool = false
    var outputVolumeObserve: NSKeyValueObservation?
    let audioSession = AVAudioSession.sharedInstance()
    var firstPicture: Bool = true
    var allPicture: Bool = true
    var normalPicture: Bool = true
    var isInProgress = false
    let notificationCenter = NotificationCenter.default
    let myImageClass = MyImageClass()
    var appInBgMode = false
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackgroundColorBasedOnMode()
        deleteButton.isHidden = true
        let images = myImageClass.loadImageFromDocumentDirectory(folderName: MyImageClass.galleryFolder)
        cities.removeAll()
        images.forEach { image in
          var name = image.imageName.replacingOccurrences(of: ".png", with: "")
            cities.append(City(selectedImage: image.selectedImage,imageName: name))
        }
        let sortArray =  cities.sorted(by: { Int($0.imageName) ?? 0 < Int($1.imageName) ?? 0 })
        cities = sortArray
        addObserver()
        collectionView.dataSource = self
        collectionView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        //setGradient()
    }
    
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //appInBgMode = false
        let volumeView = MPVolumeView(frame: CGRect(x: -CGFloat.greatestFiniteMagnitude, y: 0.0, width: 0.0, height: 0.0))
        self.view.addSubview(volumeView)
       // listenVolumeButton()
        self.collectionView.reloadData()
        collectionView.layoutIfNeeded()
        // now you can scroll however you want
        let deadlineTime = DispatchTime.now() + .seconds(1) //how to get 0.3 seconds here
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                let lastItemIndex = IndexPath(item: cities.count - 1, section: 0)
                self.collectionView.scrollToItem(at: lastItemIndex, at: .top, animated: true)
            }
        
    }
    
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewDidDisappear")
        //NotificationCenter.default.removeObserver(self, name: Notification.Name("SystemVolumeDidChange"), object: nil)
        //imageReplaceButtonTapped = false
    }
    
    
    
    func changeBackgroundColorBasedOnMode() {
        if self.traitCollection.userInterfaceStyle == .dark {
            self.view.backgroundColor = .black
        } else {
            self.view.backgroundColor = .white
        }
    }
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
    
    @IBAction func imageReplaceWithAnimationButtonTapped(_ sender: Any) {
        animationWork(type: "tap")
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
    
    @IBAction func addImageButtonTapped(_ sender: Any) {
        
    }
    @IBAction func profileButtonTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
extension ContainerViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let selectedGridSize = UserDefaultHelper.imageGridSize
        switch selectedGridSize {
        case "1X1":
            let width  = (view.frame.width - 4)
            return CGSize(width: width, height: width)
        case "3X5":
            let width  = (view.frame.width - 4)/3
            return CGSize(width: width, height: width)
        case "5X8":
            let width  = (view.frame.width - 8)/5
            return CGSize(width: width, height: width)
        case "15X25":
            let width  = (view.frame.width - 4)/15
            return CGSize(width: width, height: width)
        default:
            let width  = (view.frame.width - 4)/5
            return CGSize(width: width, height: width)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imageReplaceButtonTapped {
            if UserDefaultHelper.pictureApperation == "firstPictureApperation" {
                return firstApperanceArray.count
            }
            if UserDefaultHelper.allpictureApperation == "AllPictureApperation" {
                return firstApperanceArray.count
            }
            
        }
        return cities.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 45)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! CityCollectionViewCell
        if imageReplaceButtonTapped {
            if UserDefaultHelper.pictureApperation == "firstPictureApperation" {
                let city = firstApperanceArray[indexPath.row]
                cell.cityImageView.image = city.selectedImage
                cell.checkBoxButton.isHidden = true

                if city.isSelected {
                    cell.checkBoxButton.isHidden = !selectButton.isSelected

                    cell.checkBoxButton.setImage(city.isSelected ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: ""), for: .normal)
                }
                let selectedItems = firstApperanceArray.filter({$0.isSelected})
                deleteButton.isHidden = selectedItems.count > 0 ? false : true

                if indexPath.row == firstApperanceArray.count-1 {
                    switch UserDefaultHelper.selectedAnimationType {
                    case "ripple":
                        cell.cityImageView.setImageWithRipple(city.selectedImage)
                    case "domino":
                        cell.cityImageView.setImageWithDomino(city.selectedImage)
                    case "instant":
                        cell.cityImageView.setImageWithInstant(city.selectedImage)
                    case "glitch":
                        cell.cityImageView.setImageWithInstant(city.selectedImage)
                    default :
                        cell.cityImageView.setImageWithInstant(city.selectedImage)
                    }
                }
                return cell
                
            }
            if UserDefaultHelper.allpictureApperation == "AllPictureApperation" {
                let city = firstApperanceArray[indexPath.row]
                cell.cityImageView.image = city.selectedImage
                cell.checkBoxButton.isHidden = true

                if city.isSelected {
                    cell.checkBoxButton.isHidden = !selectButton.isSelected
                    cell.checkBoxButton.setImage(city.isSelected ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: ""), for: .normal)
                }
                let selectedItems = firstApperanceArray.filter({$0.isSelected})
                deleteButton.isHidden = selectedItems.count > 0 ? false : true
                //if indexPath.row == allApperanceArray.count-1 {
                    switch UserDefaultHelper.selectedAnimationType {
                    case "ripple":
                        cell.cityImageView.setImageWithRipple(city.selectedImage)
                    case "domino":
                        cell.cityImageView.setImageWithDomino(city.selectedImage)
                    case "instant":
                        cell.cityImageView.setImageWithInstant(city.selectedImage)
                    case "glitch":
                        cell.cityImageView.setImageWithInstant(city.selectedImage)
                    default :
                        cell.cityImageView.setImageWithInstant(city.selectedImage)
                    }
                //}
                return cell
                
            }
        }
        let city = cities[indexPath.row]
        cell.cityImageView.image = city.selectedImage
        cell.checkBoxButton.isHidden = true
        if city.isSelected {
            cell.checkBoxButton.isHidden = !selectButton.isSelected
            cell.checkBoxButton.setImage(city.isSelected ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: ""), for: .normal)
        }
        let selectedItems = cities.filter({$0.isSelected})
        deleteButton.isHidden = selectedItems.count > 0 ? false : true
        if indexPath.row == cities.count-1 {
            switch UserDefaultHelper.selectedAnimationType {
            case "ripple":
                cell.cityImageView.setImageWithRipple(city.selectedImage)
            case "domino":
                cell.cityImageView.setImageWithDomino(city.selectedImage)
            case "instant":
                cell.cityImageView.setImageWithInstant(city.selectedImage)
            case "glitch":
                cell.cityImageView.setImageWithInstant(city.selectedImage)
            default :
                cell.cityImageView.setImageWithInstant(city.selectedImage)
            }
        }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectButton.isSelected {
            if imageReplaceButtonTapped {
                firstApperanceArray[indexPath.row].isSelected = !cities[indexPath.row].isSelected
            } else {
                cities[indexPath.row].isSelected = !cities[indexPath.row].isSelected
            }
            collectionView.reloadData()

        } else {
            performSegue(withIdentifier: "showDetail", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPaths = collectionView.indexPathsForSelectedItems{
                let destinationController = segue.destination as! CityDetailViewController
                destinationController.passData = imageReplaceButtonTapped ? firstApperanceArray : cities
                destinationController.row = indexPaths[0].row
                destinationController.city = imageReplaceButtonTapped ? firstApperanceArray[indexPaths[0].row] : cities[indexPaths[0].row]
                destinationController.modalPresentationStyle = .fullScreen
                destinationController.modalTransitionStyle = .crossDissolve
                collectionView.deselectItem(at: indexPaths[0], animated: false)
            }
        }
    }
    
}



extension UIImageView{
    func setImageWithDomino(_ image: UIImage?, animated: Bool = true) {
        
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionCurlUp, animations: {
            self.image = image
        }, completion: nil)
    }
    func setImageWithRipple(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionFlipFromBottom, animations: {
            self.image = image
        }, completion: nil)
    }
    func setImageWithInstant(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration, options: .showHideTransitionViews, animations: {
            self.image = image
        }, completion: nil)
    }
}
 
extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        let y = contentSize.height - 1
        let rect = CGRect(x: 0, y: y + safeAreaInsets.bottom, width: 1, height: 1)
        scrollRectToVisible(rect, animated: animated)
    }
}
