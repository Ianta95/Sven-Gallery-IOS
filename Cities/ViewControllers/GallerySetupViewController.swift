//
//  GallerySetupViewController.swift
//  Cities
//
//  Created by Pankush Dhawan on 20/11/24.
//

import UIKit
import PhotosUI
var images:[UIImage] = []

enum GridSize: String {
    case oneMultiplyOne = "40X40"
    case threeMultiplyFive = "55X80"
    case fiveMultiplyEirth = "70X90"
    case fifteenMultiplyTwentyfive = "80X80"
    case noneOfSelected
}

class GallerySetupViewController: UIViewController {

    @IBOutlet weak var fourthRadioBoxImage: UIImageView!
    @IBOutlet weak var thirdBoxRadioImage: UIImageView!
    @IBOutlet weak var secondBoxRadioImage: UIImageView!
    @IBOutlet weak var firstBoxRadioImage: UIImageView!
    
    var selectedGridSize: GridSize = .noneOfSelected
    var imagePicker = UIImagePickerController()
    var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())

    override func viewDidLoad() {
        super.viewDidLoad()
         intialSetup()
        configuration.selectionLimit = 36 // Selection limit. Set to 0 for unlimited.
        configuration.filter = .images // he types of media that can be get.
        configuration.selection = .ordered
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func intialSetup() {
        let selectedGridSize = UserDefaultHelper.imageGridSize
        switch selectedGridSize {
            
        case "1X1":
            firstBoxRadioImage.image = UIImage(systemName: "circle.fill")
            secondBoxRadioImage.image = UIImage(systemName: "circle")
            thirdBoxRadioImage.image = UIImage(systemName: "circle")
            fourthRadioBoxImage.image = UIImage(systemName: "circle")
        case "3X5":
            firstBoxRadioImage.image = UIImage(systemName: "circle")
            secondBoxRadioImage.image = UIImage(systemName: "circle.fill")
            thirdBoxRadioImage.image = UIImage(systemName: "circle")
            fourthRadioBoxImage.image = UIImage(systemName: "circle")
        case "5X8":
            firstBoxRadioImage.image = UIImage(systemName: "circle")
            secondBoxRadioImage.image = UIImage(systemName: "circle")
            thirdBoxRadioImage.image = UIImage(systemName: "circle.fill")
            fourthRadioBoxImage.image = UIImage(systemName: "circle")
        case "15X25":
            firstBoxRadioImage.image = UIImage(systemName: "circle")
            secondBoxRadioImage.image = UIImage(systemName: "circle")
            thirdBoxRadioImage.image = UIImage(systemName: "circle")
            fourthRadioBoxImage.image = UIImage(systemName: "circle.fill")
        default:
            firstBoxRadioImage.image = UIImage(systemName: "circle")
            secondBoxRadioImage.image = UIImage(systemName: "circle")
            thirdBoxRadioImage.image = UIImage(systemName: "circle")
            fourthRadioBoxImage.image = UIImage(systemName: "circle")
        }
    }
    
    //MARK: - IB-ACTION(S)
    @IBAction func uploadButtonTapped(_ sender: Any) {
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func firstBoxButtonTapped(_ sender: Any) {
        selectedGridSize =  .oneMultiplyOne
        UserDefaultHelper.imageGridSize = "1X1"
        firstBoxRadioImage.image = UIImage(systemName: "circle.fill")
        secondBoxRadioImage.image = UIImage(systemName: "circle")
        thirdBoxRadioImage.image = UIImage(systemName: "circle")
        fourthRadioBoxImage.image = UIImage(systemName: "circle")
    }
    
    @IBAction func secondButtonTapped(_ sender: Any) {
        selectedGridSize =  .threeMultiplyFive
        UserDefaultHelper.imageGridSize = "3X5"
        firstBoxRadioImage.image = UIImage(systemName: "circle")
        secondBoxRadioImage.image = UIImage(systemName: "circle.fill")
        thirdBoxRadioImage.image = UIImage(systemName: "circle")
        fourthRadioBoxImage.image = UIImage(systemName: "circle")
    }
    @IBAction func threeButtonTapped(_ sender: Any) {
        selectedGridSize =  .fiveMultiplyEirth
        UserDefaultHelper.imageGridSize = "5X8"
        firstBoxRadioImage.image = UIImage(systemName: "circle")
        secondBoxRadioImage.image = UIImage(systemName: "circle")
        thirdBoxRadioImage.image = UIImage(systemName: "circle.fill")
        fourthRadioBoxImage.image = UIImage(systemName: "circle")
    }
    @IBAction func fourthButtonTapped(_ sender: Any) {
        selectedGridSize =  .fifteenMultiplyTwentyfive
        UserDefaultHelper.imageGridSize = "15X25"
        firstBoxRadioImage.image = UIImage(systemName: "circle")
        secondBoxRadioImage.image = UIImage(systemName: "circle")
        thirdBoxRadioImage.image = UIImage(systemName: "circle")
        fourthRadioBoxImage.image = UIImage(systemName: "circle.fill")
    }
    
}
//extension GallerySetupViewController: PHPickerViewControllerDelegate {
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.delegate = nil
//        var myImageClass = MyImageClass()
//
//        picker.dismiss(animated: true) { [weak self] in
//            var counter = UserDefaultHelper.ImageCounter ?? 0
//
//            let dispatchGroup: DispatchGroup = DispatchGroup()
//      
//            var orderIDArr: [String] = []
//            var orderMap = [String : Media]()
//
//            for result in results {
//                let uniqueID = result.assetIdentifier ?? UUID().uuidString
//                orderIDArr.append(uniqueID)
//                dispatchGroup.enter()
//                result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
//                    if let url = url{
//                        if let filter = CIFilter(imageURL: url),
//                           let ciImage = filter.outputImage{
//                            let image = UIImage(ciImage: ciImage)
//                            myImageClass.saveImageToDocumentDirectory(image: image ,pictureName: String(counter) ,folderName: MyImageClass.galleryFolder)
//                            cities.append(City(selectedImage: image, imageName: String(counter)))
//                            counter = counter + 1
//                            UserDefaultHelper.ImageCounter = counter
//                            //orderMap[uniqueID] = Media(image: image, identifier: result.assetIdentifier)
//                            dispatchGroup.leave()
//                        }
//                    } else {
//                        dispatchGroup.leave()
//                    }
//                }
//            }
//            dispatchGroup.notify(queue: .main) { [weak self] in
//                var arrMedia: [Media] = []
////                for uid in orderIDArr {
////                    if let media = orderMap[uid] {
////                        arrMedia.append(media)
////                    }
////                }
//                self?.navigationController?.popToRootViewController(animated: true)
//            }
//            
//        }
//    }
//    
//    
//}



//extension GallerySetupViewController: PHPickerViewControllerDelegate {
// func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.dismiss(animated: true)
//        var myImageClass = MyImageClass()
//        var counter = UserDefaultHelper.ImageCounter ?? 0
//        if results.count >= 1 {
//
//            for i in 0..<results.count {
//                let secondItemProvider = results[i].itemProvider
//                if secondItemProvider.canLoadObject(ofClass: UIImage.self) {
//                    secondItemProvider.loadObject(ofClass: UIImage.self) { [weak self]  image, error in
//                       
//                        
//                        if let secondImage = image as? UIImage,  let _ = self {
//                            myImageClass.saveImageToDocumentDirectory(image: secondImage ,pictureName: String(counter) ,folderName: MyImageClass.galleryFolder)
//                            cities.append(City(selectedImage: secondImage, imageName: String(counter)))
//                            counter = counter + 1
//                            UserDefaultHelper.ImageCounter = counter
//
//                            }
//                        if cities.count == results.count {
//                            DispatchQueue.main.async {
//                               
//                                self?.navigationController?.popToRootViewController(animated: true)
//
//                            }
//
//                        }
//
//                        }
//                       
//                    }
//
//                }
//
//            }
//        
//
//    }
//}

extension GallerySetupViewController: PHPickerViewControllerDelegate {
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let group = DispatchGroup()
        var images = [UIImage]()
        var order = [String]()
        var asyncDict = [String:UIImage]()
        var counter = UserDefaultHelper.ImageCounter ?? 0
        var myImageClass = MyImageClass()
        
        for result in results {
            order.append(result.assetIdentifier ?? "")
            print(result.assetIdentifier)
            group.enter()
            let provider = result.itemProvider
            print(provider)
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    guard let updatedImage = image as? UIImage else {group.leave();return}
                    asyncDict[result.assetIdentifier ?? ""] = updatedImage
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
        for id in order {
            var image = asyncDict[id]!
            images.append(asyncDict[id]!)
            myImageClass.saveImageToDocumentDirectory(image: image ,pictureName: String(counter) ,folderName: MyImageClass.galleryFolder)
            cities.append(City(selectedImage: image, imageName: String(counter)))
            counter = counter + 1
            UserDefaultHelper.ImageCounter = counter
        }
        print("images ankush", images)
            //  navigationController?.popToRootViewController(animated: true)
        }
    }
    
}

class MyImageClass {
    static var galleryFolder = "GalleryImages"
    static var ForceUploadFolder = "ForceUploadImages"

    func saveImageToDocumentDirectory(image: UIImage,pictureName:String = "", folderName:String) {
        var objCBool: ObjCBool = true
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
        let folderPath = mainPath + "/\(folderName)/"

        let isExist = FileManager.default.fileExists(atPath: folderPath, isDirectory: &objCBool)
        if !isExist {
            do {
                try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }

        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var imageName = ""
        if pictureName == "" {
            imageName = "\(randomString(length: 10)).png"
        }else {
            imageName = "\(pictureName).png"
        }
        let imageUrl = documentDirectory.appendingPathComponent("\(folderName)/\(imageName)")
        if let data = image.jpegData(compressionQuality: 1.0){
            do {
                try data.write(to: imageUrl)
            } catch {
                print("error saving", error)
            }
        }
    }
    
    func removeSavedImage(folderName:String = MyImageClass.galleryFolder, imageName: String){
        // Save the video to disk.
        let fileManager = FileManager.default

        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagePath = documentsDirectory.appendingPathComponent(imageName)
        let directoryURL = documentsDirectory.appendingPathComponent(folderName)

        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
            fileURLs.forEach { url in
                if url.lastPathComponent == imagePath.lastPathComponent {
                    try? FileManager.default.removeItem(at: url)
                }
            }
            // process files
        } catch {
            print(error)
        }
        
        
        // Delete the video from disk
    }
    
     func removeImage(itemName:String) {
      let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var directoryURL:URL?
        var imageName = ""
        directoryURL = documentsURL.appendingPathComponent(itemName)
      guard let dirPath = directoryURL else {
        return
      }
      let filePath = "\(dirPath)/\(itemName).png"
      do {
          try fileManager.removeItem(atPath: filePath)
      } catch let error as NSError {
        print(error.debugDescription)
      }
    }
    func loadImageFromDocumentDirectory( folderName:String, pictureName:String = "") -> [City] {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var directoryURL:URL?
        var imageName = ""
        directoryURL = documentsURL.appendingPathComponent(folderName)

        if pictureName != "" {
            imageName = "\(pictureName).png"
            directoryURL =  directoryURL?.appendingPathComponent(imageName)
            if FileManager.default.fileExists(atPath: directoryURL!.path){
                if let image = UIImage(contentsOfFile: directoryURL!.path) {
                    
                    return [City(selectedImage: image, imageName: imageName)]
                }
                return []
            }
                        
        }
        
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: directoryURL!, includingPropertiesForKeys: nil)
            var images = [City]()
            fileURLs.forEach { url in
                if let image = UIImage(contentsOfFile: url.path)  {
                    images.append(City(selectedImage: image,imageName: url.lastPathComponent))
                }
            }
            return images
            // process files
        } catch {
            print(error)
        }
        return []
   }
    
    func randomString(length: Int) -> String {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
}

class Media {
    private let image: UIImage
    private let identifier: String?
    init(image: UIImage, identifier: String? = nil){
        self.image = image
        self.identifier = identifier
    }
    public func getImage() -> UIImage {
        return self.image
    }
    public func getIdentifier() -> String? {
        return self.identifier
    }
}
