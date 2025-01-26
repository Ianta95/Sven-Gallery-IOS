//
//  ContainerViewController+UICollectionView.swift
//  Cities
//
//  Created by Jesus Barragan  on 25/01/25.
//

import UIKit
import Foundation
import PhotosUI
import MediaPlayer

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
