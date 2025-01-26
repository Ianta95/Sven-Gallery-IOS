//
//  ContainerViewController+UI.swift
//  Cities
//
//  Created by Jesus Barragan  on 25/01/25.
//

import UIKit
import Foundation
import PhotosUI
import MediaPlayer

extension ContainerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    private func prepareUI(){
        changeBackgroundColorBasedOnMode()
        deleteButton.isHidden = true
    }
    
    func changeBackgroundColorBasedOnMode() {
        self.view.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? .black : .white
    }
}
