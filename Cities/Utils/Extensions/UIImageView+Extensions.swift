//
//  UIImageView+Extensions.swift
//  Cities
//
//  Created by Jesus Barragan  on 25/01/25.
//
import UIKit

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
