//
//  PredictionView.swift
//  TrainyP
//
//  Created by Linh Chu on 10.06.23.
//

import SwiftUI
import UIKit
import CoreML
import Vision

struct PredictionView: View {
//    var trainNN = TrainNearestNeighborsViewController()
//    var checkLabel = CheckLabel()
    @EnvironmentObject var selectedLabel: LabelsViewModel
//    @State var id = 0
//    @State var confirmResetDialog = false
//    @State var newLabel = ""
    @State var isGalleryShowing = false
//    @State var selectedImage: UIImage?
//    @State var predictionLabel = "?"
//    @State var predictionConf = 0.0
//    @State var selectedLabel: String = "nothing"
//    @State var test: [UIImage] = []
//    var noLabel = "Please add a label"
//    var nothingSelected = "nothing"
//    var trained = "not trained"
    
    var body: some View {
        VStack{
//            Spacer()
            if selectedLabel.selectedImage != nil{
                Image(uiImage: selectedLabel.selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }else{
                Button{
                    //show the image picker
                    isGalleryShowing = true
//                    id = id + 1
                    
                }label:{
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 100, height: 70)
                }
                .padding(.init(top: 65, leading: 50, bottom: 65, trailing: 50))
                .foregroundColor(.blue) // 2
                .background(.gray)
            }
            HStack{
                Button{
                    //show the image picker
                    isGalleryShowing = true
//                    id = id + 1
                }label:{
                    Text("Wähle ein Bild")
                }
            }
            Text(selectedLabel.predictionLabel)
            Text(String(format: "%.1f%%", selectedLabel.predictionConf * 100))
        }
        .onAppear{
            DispatchQueue.main.async{
                if let image = selectedLabel.selectedImage{
                    let model = Models.loadTrainedNearestNeighbors()
                    let predictor = Predictor(model: model!)
                    let imageOptions: [MLFeatureValue.ImageOption: Any] = [
                      .cropAndScale: VNImageCropAndScaleOption.scaleFill.rawValue
                    ]
                    let featureValue = try? MLFeatureValue(cgImage:                                      image.cgImage!, constraint: imageConstraint(model: model!), options: imageOptions)
                    let prediction = predictor.predict(image: featureValue!)
                    selectedLabel.predictionLabel = prediction!.label
                    selectedLabel.predictionConf = prediction!.confidence
                }
            }
        }
        .sheet(isPresented: $isGalleryShowing, onDismiss: nil){
            ShowGallery(selectedImage: $selectedLabel.selectedImage, isGalleryShowing: $isGalleryShowing, predictionLabel: $selectedLabel.predictionLabel, predictionConf: $selectedLabel.predictionConf, predict: true)
        }
    }
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        PredictionView()
//        ContentView(labels: LabelsViewModel())
    }
}