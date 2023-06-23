//
//  ContentView.swift
//  TrainyP
//
//  Created by Linh Chu on 23.04.23.
//

import SwiftUI
import UIKit

struct ContentView: View {
//    var trainNN = TrainNearestNeighborsViewController()
//    var checkLabel = CheckLabel()
//    @ObservedObject var selectedLabel: LabelsViewModel
//    @State var id = 0
//    @State var confirmResetDialog = false
//    @State var newLabel = ""
//    @State var isGalleryShowing = false
//    @State var selectedImage: UIImage?
//    @State var predictionLabel = "?"
//    @State var predictionConf = 0.0
////    @State var selectedLabel: String = "nothing"
//    @State var test: [UIImage] = []
////    var noLabel = "Please add a label"
//    var nothingSelected = "nothing"
//    var trained = "not trained"
//
//    var body: some View {
//        NavigationView{
//        VStack{
//            Spacer()
//            if selectedImage != nil{
//                Image(uiImage: selectedImage!)
//                    .resizable()
//                    .frame(width: 200, height: 200)
//            }else{
//                Button{
//                    //show the image picker
//                    isGalleryShowing = true
//                    id = id + 1
//
//                }label:{
//                    Text("+")
//                }
//                .padding(.init(top: 0, leading: 100, bottom: 100, trailing: 100))
//                .foregroundColor(.blue) // 2
//                .background(.gray)
//            }
//            HStack{
//                Button{
//                    //show the image picker
//                    isGalleryShowing = true
//                    id = id + 1
//                }label:{
//                    Text("Wähle ein Bild")
//                }
//            }
//            Text(predictionLabel)
//            Text(String(format: "%.1f%%", predictionConf * 100))
//            Form{
//                Section(header: Text("Training")) {
//                    HStack{
////                    Text("Label")
//                        Picker("Label", selection: $selectedLabel.label) {
//                        ForEach(labels.labelNames, id: \.self) { i in
////                            Text($0)
//                            Text(i)
//                        }
//                    }
//                    .disabled(labels.labelNames==[])
//                    .id(id)
//                    }
//                    .id(id)
//
//                    Text("You selected: \(selectedLabel.label)")
//                    HStack{
//                        TextField("New Label...", text: $newLabel)
//                        Button(action: {
//                            labels.addLabel(newLabel)
//                            id = id + 1
//                            newLabel = ""
//                        }){
//                            Text("Add Label")
//                        }
//                        .disabled(!(checkLabel.checkLabel(label: newLabel)))
//                        .padding(.horizontal)
//                    }
//                }
//
//            }
//            Spacer()
//            HStack{
//                Button{
//                    confirmResetDialog = true
//                } label: {
//                    Text("Reset Model")
//                }
//                .padding()
//                .confirmationDialog("Reset Model", isPresented: $confirmResetDialog, titleVisibility: .visible){
//                    Button("Reset", role: .destructive){
//                        Models.deleteTrainedNearestNeighbors()
//                        Models.copyEmptyNearestNeighbors()
//                        labels.resetLabel()
//                        id = id + 1
//                        selectedLabel.label = "nothing"
//                    }
//                    }message: {
//                        Text("Do you want to reset the model?")
//                }
//                Spacer()
//                Button(action: {
//                    trainNN.model = Models.loadTrainedNearestNeighbors()
//                    if let cgImage = selectedImage?.cgImage{
//                        trainNN.cgImage = cgImage
//                    }
//                    if let image = selectedImage {
//                        test.append(image)
//                    }
//                    trainNN.trueLabel = selectedLabel.label
//                    trainNN.train()
//                }){
//                    Text("Train")
//                }
//                .disabled(trainNN.disableButton(label: selectedLabel.label, image: selectedImage))
//                .padding()
//            }
//        }
//        .sheet(isPresented: $isGalleryShowing, onDismiss: nil){
//            ShowGallery(selectedImage: $selectedImage, isGalleryShowing: $isGalleryShowing, predictionLabel: $predictionLabel, predictionConf: $predictionConf)
//        }
//    }
//    }
    @ObservedObject var selectedLabel: LabelsViewModel
//    @State var id = 0
//    @State var confirmResetDialog = false
//    @State var newLabel = ""
//    @State var isGalleryShowing = false
//    @State var selectedImage: UIImage?
//    @State var predictionLabel = "?"
//    @State var predictionConf = 0.0
//    @State var selectedLabel: String = "nothing"
//    @State var test: [UIImage] = []
//    var noLabel = "Please add a label"
//    var nothingSelected = "nothing"
//    var trained = "not trained"
    
    var body: some View {
        TabView{
            PredictionView()
                .tabItem{
                    Label("Vorhersage", systemImage: "eye.fill")
                }
                .environmentObject(selectedLabel)
//                .onAppear {
//                    
//                }
            TrainingView()
                .tabItem{
                    Label("Training", systemImage: "hammer")
                }
                .environmentObject(selectedLabel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        ContentView( selectedLabel: LabelsViewModel())
            .padding(11.0)
//        ContentView(labels: LabelsViewModel())
    }
}
