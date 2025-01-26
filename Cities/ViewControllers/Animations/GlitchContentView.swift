//
//  GlitchContentView.swift
//  Cities
//
//  Created by Jesus Barragan  on 25/01/25.
//

import UIKit
import SwiftUI

struct GlitchContentView: View {
    @State var isGlitching = false
    @State var imageSelected: UIImage
    @State var bounds: CGRect
    var body: some View {
        VStack {
            GlitchEffectView(
                content: Image(uiImage: imageSelected).resizable().scaledToFill().foregroundColor(.primary), isGlitching: $isGlitching
            ).frame(width: bounds.width, height: bounds.height).task(delay)
        }
    }
    
    private func delay() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        isGlitching = true
    }
    
   
}

extension UIViewController {
    func createGlitch(image: UIImage, bounds: CGRect){
        /*let pieces = 3
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        stackView.spacing = 0
        stackView.backgroundColor = .brown
        stackView.distribution = .fill
        stackView.alignment = .fill
        let images = image.matrixVertical(pieces)
        for image in images {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            stackView.addArrangedSubview(imageView)
        }*/
        
        
        let swiftUIView = GlitchContentView(imageSelected: image, bounds: bounds)
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.didMove(toParent: self)
    }
    
    
}

extension UIImage {
    func matrix(_ rows: Int, _ columns: Int) -> [UIImage] {
        let y = (size.height / CGFloat(rows)).rounded()
        let x = (size.width / CGFloat(columns)).rounded()
        var images: [UIImage] = []
        images.reserveCapacity(rows * columns)
        guard let cgImage = cgImage else { return [] }
        (0..<rows).forEach { row in
            (0..<columns).forEach { column in
                var width = Int(x)
                var height = Int(y)
                if row == rows-1 && size.height.truncatingRemainder(dividingBy: CGFloat(rows)) != 0 {
                    height = Int(size.height - size.height / CGFloat(rows) * (CGFloat(rows)-1))
                }
                if column == columns-1 && size.width.truncatingRemainder(dividingBy: CGFloat(columns)) != 0 {
                    width = Int(size.width - (size.width / CGFloat(columns) * (CGFloat(columns)-1)))
                }
                let originPoint = CGPoint(x: column * Int(x), y:  row * Int(x))
                let croppingPoint = CGRect(origin: originPoint, size: CGSize(width: width, height: height))
                if let image = cgImage.cropping(to: croppingPoint) {
                    images.append(UIImage(cgImage: image, scale: scale, orientation: imageOrientation))
                }
            }
        }
        return images
    }
    
    func matrixVertical(_ rows: Int) -> [UIImage] {
        let y = (size.height / CGFloat(rows)).rounded()
        let x = (size.width / CGFloat(1)).rounded()
        var images: [UIImage] = []
        images.reserveCapacity(rows)
        guard let cgImage = cgImage else { return [] }
        (0..<rows).forEach { row in
            var width = Int(x)
             var height = Int(y)
            var totalHeight = Int(y)
                
             if row == rows-1 && size.height.truncatingRemainder(dividingBy: CGFloat(rows)) != 0 {
                 height = Int(size.height - size.height / CGFloat(rows) * (CGFloat(rows)-1))
             }
            width = Int(size.width)
            print(scale)
            let originPoint = CGPoint(x: 0, y:  row * Int(y))
            let croppingPoint = CGRect(origin: originPoint, size: CGSize(width: width, height: height))
            if let image = cgImage.cropping(to: croppingPoint) {
                images.append(UIImage(cgImage: image, scale: 1.0, orientation: imageOrientation))
             }
        }
        return images
    }
}
