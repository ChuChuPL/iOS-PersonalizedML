//
//  PickImage.swift
//  TrainyP
//
//  Created by Linh Chu on 23.04.23.
//

import Foundation
import UIKit
import SwiftUI
import CoreML
import Vision

struct ShowGallery: UIViewControllerRepresentable{
    
    @Binding var selectedImage: UIImage?
    @Binding var isGalleryShowing: Bool
    @Binding var predictionLabel: String
    @Binding var predictionConf: Double
    var predict: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController{
        Models.copyEmptyNearestNeighbors() //neu
        let showGallery = UIImagePickerController()
        showGallery.sourceType = .photoLibrary
        showGallery.delegate = context.coordinator
        return showGallery
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    func makeCoordinator() -> Coordinator{
        return Coordinator(self)
    }
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var parent: ShowGallery
    
    init(_ picker: ShowGallery){
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async{
                self.parent.selectedImage = image
                //Linh Neu
                if(self.parent.predict){
                    let model = Models.loadTrainedNearestNeighbors()
                    let predictor = Predictor(model: model!)
                    let imageOptions: [MLFeatureValue.ImageOption: Any] = [
                      .cropAndScale: VNImageCropAndScaleOption.scaleFill.rawValue
                    ]
                    let featureValue = try? MLFeatureValue(cgImage: image.cgImage!, constraint: imageConstraint(model: model!), options: imageOptions)
                    let prediction = predictor.predict(image: featureValue!)
                    self.parent.predictionLabel = prediction!.label
                    self.parent.predictionConf = prediction!.confidence
                    print(prediction!.probabilities)
                ///
                }
            }
        }
        parent.isGalleryShowing = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        parent.isGalleryShowing = false
    }
}
