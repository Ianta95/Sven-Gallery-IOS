//
//  City.swift
//  Cities
//
//  Created by Yasar on 29.01.2021.
//

import Foundation
import UIKit
class City {
    var selectedImage: UIImage
    var imageName: String
    var isSelected = false
    init(selectedImage:UIImage, imageName: String){
        self.selectedImage = selectedImage
        self.imageName = imageName
    }
}
