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
    
    @IBOutlet weak var generalView: UIView! { didSet { generalView.backgroundColor = .blue } }
    @IBOutlet weak var topView: UIView! { didSet { topView.backgroundColor = .green } }
    @IBOutlet weak var bottomView: UIView! { didSet { bottomView.backgroundColor = .red } }
    @IBOutlet weak var collectionView: UICollectionView! { didSet { collectionView.backgroundColor = .orange } }
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
    
}
