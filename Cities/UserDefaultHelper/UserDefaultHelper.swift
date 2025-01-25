//
//  UserDefaultHelper.swift
//  Rider
//
//  Created by Mac mini on 10/5/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import UIKit
enum AnimationType: String {
    case ripple = "ripple"
    case instant = "instant"
    case domino = "domino"
    case glitch = "glitch"
}
 enum Defaults: String {
    
    case imageGridSize = "imageGridSize"
     case imageCounter = "ImageCounter"

    case selectedImageData = "selectedImageData"
    //case selectedImageBoxForForceUpload = "selectedImageBoxForForceUpload"
    case selectedImageBoxForForceUpload1 = "selectedImageBoxForForceUpload1"

    case selectedImagesFromGallerySetup = "selectedImagesFromGallerySetup"
    case animationType = "animationType"
    case pictureApperation = "pictureApperation"
    case allpictureApperation = "allpictureApperation"
    case backtoApperation = "backtoApperation"

    case changePictureDelay1 = "changePictureDelay1"
    case changePictureDelay2 = "changePictureDelay2"
    case changePictureDelay3 = "changePictureDelay3"

    case tapTrigger1 = "tapTrigger1"
    case tapTrigger2 = "tapTrigger2"
    case tapTrigger3 = "tapTrigger3"
}

final class UserDefaultHelper {
    
    static var imageGridSize: String? {
        set{
            _set(value: newValue, key: .imageGridSize)
        } get {
            return _get(valueForKay: .imageGridSize) as? String
        }
    }
    
    static var ImageCounter: Int? {
        set{
            _set(value: newValue, key: .imageCounter)
        } get {
            return _get(valueForKay: .imageCounter) as? Int
        }
    }
    static var tapTrigger1: String? {
        set{
            _set(value: newValue, key: .tapTrigger1)
        } get {
            return _get(valueForKay: .tapTrigger1) as? String
        }
    }
    static var tapTrigger2: String? {
        set{
            _set(value: newValue, key: .tapTrigger2)
        } get {
            return _get(valueForKay: .tapTrigger2) as? String
        }
    }
    static var tapTrigger3: String? {
        set{
            _set(value: newValue, key: .tapTrigger3)
        } get {
            return _get(valueForKay: .tapTrigger3) as? String
        }
    }
    static var changePictureDelay1: Double? {
        set{
            _set(value: newValue, key: .changePictureDelay1)
        } get {
            return _get(valueForKay: .changePictureDelay1) as? Double
        }
    }
    static var changePictureDelay2: Double? {
        set{
            _set(value: newValue, key: .changePictureDelay2)
        } get {
            return _get(valueForKay: .changePictureDelay2) as? Double
        }
    }
    static var changePictureDelay3: Double? {
        set{
            _set(value: newValue, key: .changePictureDelay3)
        } get {
            return _get(valueForKay: .changePictureDelay3) as? Double
        }
    }
    static var pictureApperation: String? {
        set{
            _set(value: newValue, key: .pictureApperation)
        } get {
            return _get(valueForKay: .pictureApperation) as? String
        }
    }
    static var allpictureApperation: String? {
        set{
            _set(value: newValue, key: .allpictureApperation)
        } get {
            return _get(valueForKay: .allpictureApperation) as? String
        }
    }
    
    static var backtoApperation: String? {
        set{
            _set(value: newValue, key: .backtoApperation)
        } get {
            return _get(valueForKay: .backtoApperation) as? String
        }
    }
    static var selectedAnimationType: String? {
        set{
            _set(value: newValue, key: .animationType)
        } get {
            return _get(valueForKay: .animationType) as? String
        }
    }
    static var selectedImagesFromGallerySetup: [UIImage]? {
        set{
            _set(value: newValue, key: .selectedImagesFromGallerySetup)
        } get {
            return _get(valueForKay: .selectedImagesFromGallerySetup) as?  [UIImage]
        }
    }
    
    static var selectedImageData: Data? {
        set{
            _set(value: newValue, key: .selectedImageData)
        } get {
            return _get(valueForKay: .selectedImageData) as? Data
        }
    }
//    static var selectedImageBoxForForceUpload: String? {
//        set{
//            _set(value: newValue, key: .selectedImageBoxForForceUpload)
//        } get {
//            return _get(valueForKay: .selectedImageBoxForForceUpload) as? String
//        }
//    }
    private static func _set(value: Any?, key: Defaults) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    private static func _get(valueForKay key: Defaults)-> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)

    }
    
    private static func _delete(valueForKay key: Defaults) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()

    }
    
    static func deleteGridSize() {
        UserDefaults.standard.removeObject(forKey: Defaults.imageGridSize.rawValue)
    }
    
    
}


