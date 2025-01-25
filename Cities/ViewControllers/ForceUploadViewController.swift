//
//  ForceUploadViewController.swift
//  Cities
//
//  Created by Pankush Dhawan on 21/11/24.
//

import UIKit

class ForceUploadViewController: UIViewController {
    
    @IBOutlet weak var fourthImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var fourthRadioImageView: UIImageView!
    @IBOutlet weak var thirdRadioImageView: UIImageView!
    @IBOutlet weak var secondRadioImageView: UIImageView!
    @IBOutlet weak var sixthRadioImage: UIImageView!
    @IBOutlet weak var firstRadioImageView: UIImageView!
    @IBOutlet weak var fifthRadioImage: UIImageView!
    @IBOutlet weak var fifthImageView: UIImageView!
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var sixthImageView: UIImageView!
    enum ImageBoxType: String {
        case first
        case second
        case third
        case fourth
        case fifth
        case sixth
        case nothing
    }
    
    var uploadImageButtonTapped: ImageBoxType = .nothing
    var selectedImageView: ImageBoxType = .nothing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        if let image = getImage(name: "1"){
            self.firstImageView.image = image
        }
        if let image = getImage(name: "2") {
            self.secondImageView.image = image
        }
        if let image = getImage(name: "3") {
            self.thirdImageView.image = image
        }
        if let image = getImage(name: "4") {
            self.fourthImageView.image = image
        }
        if let image = getImage(name: "5") {
            self.firstImageView.image = image
        }
        if let image = getImage(name: "6") {
            self.sixthImageView.image = image
        }
        print("selected",getUserDefault(valueForKay: .selectedImageBoxForForceUpload1) )
        if getUserDefault(valueForKay: .selectedImageBoxForForceUpload1) == "1" {
            firstRadioImageView.image =  UIImage(systemName: "circle.fill")
            
        }else if getUserDefault(valueForKay: .selectedImageBoxForForceUpload1) == "2" {
            secondRadioImageView.image =  UIImage(systemName: "circle.fill")

        }else if getUserDefault(valueForKay: .selectedImageBoxForForceUpload1) == "3" {
            thirdRadioImageView.image =  UIImage(systemName: "circle.fill")

        }else if getUserDefault(valueForKay: .selectedImageBoxForForceUpload1) == "4" {
            fourthRadioImageView.image =  UIImage(systemName: "circle.fill")

        }else if getUserDefault(valueForKay: .selectedImageBoxForForceUpload1) == "5" {
            fifthRadioImage.image =  UIImage(systemName: "circle.fill")
        }else if getUserDefault(valueForKay: .selectedImageBoxForForceUpload1) == "6" {
            sixthRadioImage.image =  UIImage(systemName: "circle.fill")
        }
    }
    
    func getImage(name:String) -> UIImage? {
        let myImageClass = MyImageClass()
        var images = myImageClass.loadImageFromDocumentDirectory(folderName: MyImageClass.ForceUploadFolder, pictureName: name)
        if images.count > 0 {
            return images.first?.selectedImage
        }
        return nil
    }
    func presentImageViewController() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - IBACTION(S)
    @IBAction func firstUploadButtonTapped(_ sender: Any) {
        uploadImageButtonTapped = .first
        presentImageViewController()
        
    }
    @IBAction func secondUploadButtonTapped(_ sender: Any) {
        uploadImageButtonTapped = .second
        presentImageViewController()
        
    }
    @IBAction func thirdUploadButtonTapped(_ sender: Any) {
        uploadImageButtonTapped = .third
        presentImageViewController()
        
    }
    
    @IBAction func fourthUploadButtonTapped(_ sender: Any) {
        uploadImageButtonTapped = .fourth
        presentImageViewController()
    }
    
    @IBAction func fifthButtonTapped(_ sender: Any) {
        uploadImageButtonTapped = .fifth
        presentImageViewController()
    }
    
    @IBAction func sixthButtonTapped(_ sender: Any) {
        uploadImageButtonTapped = .sixth
        presentImageViewController()
    }
    
    @IBAction func firstRadioButtonTapped(_ sender: Any) {

        selectedImageView = .first
        setUserDefault(value: "1", key: .selectedImageBoxForForceUpload1)
        firstRadioImageView.image =  UIImage(systemName: "circle.fill")
        secondRadioImageView.image =  UIImage(systemName: "circle")
        thirdRadioImageView.image =  UIImage(systemName: "circle")
        fourthRadioImageView.image =  UIImage(systemName: "circle")
        fifthRadioImage.image =  UIImage(systemName: "circle")
        sixthRadioImage.image =  UIImage(systemName: "circle")
        print(getUserDefault(valueForKay: .selectedImageBoxForForceUpload1))


    }
    @IBAction func secondRadioButtonTapped(_ sender: Any) {
        setUserDefault(value: "2", key: .selectedImageBoxForForceUpload1)
        selectedImageView = .second
        firstRadioImageView.image =  UIImage(systemName: "circle")
        secondRadioImageView.image =  UIImage(systemName: "circle.fill")
        thirdRadioImageView.image =  UIImage(systemName: "circle")
        fourthRadioImageView.image =  UIImage(systemName: "circle")
        fifthRadioImage.image =  UIImage(systemName: "circle")
        sixthRadioImage.image =  UIImage(systemName: "circle")
        print(getUserDefault(valueForKay: .selectedImageBoxForForceUpload1))


    }
    @IBAction func thirdRadioButtonTapped(_ sender: Any) {
        setUserDefault(value: "3", key: .selectedImageBoxForForceUpload1)
        selectedImageView = .third
        firstRadioImageView.image =  UIImage(systemName: "circle")
        secondRadioImageView.image =  UIImage(systemName: "circle")
        thirdRadioImageView.image =  UIImage(systemName: "circle.fill")
        fourthRadioImageView.image =  UIImage(systemName: "circle")
        fifthRadioImage.image =  UIImage(systemName: "circle")
        sixthRadioImage.image =  UIImage(systemName: "circle")
        print(getUserDefault(valueForKay: .selectedImageBoxForForceUpload1) )

    }
    @IBAction func fourthRadioButtonTapped(_ sender: Any) {
        setUserDefault(value: "4", key: .selectedImageBoxForForceUpload1)
        selectedImageView = .fourth
        firstRadioImageView.image =  UIImage(systemName: "circle")
        secondRadioImageView.image =  UIImage(systemName: "circle")
        thirdRadioImageView.image =  UIImage(systemName: "circle")
        fourthRadioImageView.image =  UIImage(systemName: "circle.fill")
        fifthRadioImage.image =  UIImage(systemName: "circle")
        sixthRadioImage.image =  UIImage(systemName: "circle")
        print(getUserDefault(valueForKay: .selectedImageBoxForForceUpload1) )

    }
    
    @IBAction func fifthRadioButtonTapped(_ sender: Any) {
        setUserDefault(value: "5", key: .selectedImageBoxForForceUpload1)
        selectedImageView = .fifth
        firstRadioImageView.image =  UIImage(systemName: "circle")
        secondRadioImageView.image =  UIImage(systemName: "circle")
        thirdRadioImageView.image =  UIImage(systemName: "circle")
        fourthRadioImageView.image =  UIImage(systemName: "circle")
        fifthRadioImage.image =  UIImage(systemName: "circle.fill")
        sixthRadioImage.image =  UIImage(systemName: "circle")

        print(getUserDefault(valueForKay: .selectedImageBoxForForceUpload1) )
    }
    @IBAction func sixthRadioButtonTapped(_ sender: Any) {
        setUserDefault(value: "6", key: .selectedImageBoxForForceUpload1)
        selectedImageView = .sixth
        firstRadioImageView.image =  UIImage(systemName: "circle")
        secondRadioImageView.image =  UIImage(systemName: "circle")
        thirdRadioImageView.image =  UIImage(systemName: "circle")
        fourthRadioImageView.image =  UIImage(systemName: "circle")
        fifthRadioImage.image =  UIImage(systemName: "circle")
        sixthRadioImage.image =  UIImage(systemName: "circle.fill")

        print(getUserDefault(valueForKay: .selectedImageBoxForForceUpload1) )
    }
    func addLoader() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    func hideLoader(){
        dismiss(animated: true)
    }
    
    func setUserDefault(value: String, key: Defaults) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getUserDefault(valueForKay key: Defaults)-> String {
        return UserDefaults.standard.value(forKey: key.rawValue) as? String ?? ""

    }
    
}
extension ForceUploadViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        let data = image.jpegData(compressionQuality: 1.0)
        //UserDefaultHelper.selectedImageData = data

        var name = ""

        switch self.uploadImageButtonTapped {
        case .first:
            name = "1"
            self.firstImageView.image = image
        case .second:
            name = "2"
            self.secondImageView.image = image
        case .third:
            name = "3"
            self.thirdImageView.image = image
        case .fourth:
            name = "4"
            self.fourthImageView.image = image
        case .nothing:
            print("nothing selected")
        case .fifth:
            name = "5"
            self.fifthImageView.image = image
        case .sixth:
            name = "6"
            self.sixthImageView.image = image
        }
        var myImageClass = MyImageClass()
        myImageClass.saveImageToDocumentDirectory(image: image,pictureName: name, folderName: MyImageClass.ForceUploadFolder)
        picker.dismiss(animated: true, completion: nil)

    }
   
}
