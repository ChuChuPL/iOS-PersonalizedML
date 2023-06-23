//
//  TrainingView.swift
//  TrainyP
//
//  Created by Linh Chu on 10.06.23.
//

import SwiftUI
import UIKit

struct TrainingView: View {
    var trainNN = TrainNearestNeighborsViewController()
    var checkLabel = CheckLabel()
    @EnvironmentObject var selectedLabel: LabelsViewModel
    @State var id = 0
    @State var confirmResetDialog = false
    @State var newLabel = ""
    @State var isGalleryShowing = false
//    @State var selectedImage: UIImage?
    @State var predictionLabel = "?"
    @State var predictionConf = 0.0
//    @State var selectedLabel: String = "nothing"//    var noLabel = "Please add a label"
//    var nothingSelected = "nothing"
//    var trained = "not trained"
    
    var body: some View {
        NavigationView{
//            HStack{
//                Button{
//                    confirmResetDialog = true
//                } label: {
//                    Text("Reset Model")
//                }
//                .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 0))
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
//                    if let cgImage = selectedLabel.selectedImage?.cgImage{
//                        trainNN.cgImage = cgImage
//                    }
//                    trainNN.trueLabel = selectedLabel.label
//                    trainNN.train()
//                }){
//                    Text("Train")
//                }
//                .disabled(trainNN.disableButton(label: selectedLabel.label, image: selectedLabel.selectedImage))
//                .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 10))
//            }
            VStack{
//                Spacer()
                
                Spacer()
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
//                    .frame(height: 200)
                    .padding(.init(top: 65, leading: 50, bottom: 65, trailing: 50))
                    .foregroundColor(.blue) // 2
                    .background(.gray)
                }
                HStack{
                    Button{
                        //show the image picker
                        isGalleryShowing = true
                        id = id + 1
                    }label:{
                        Text("Wähle ein Bild")
                    }
                }
    //            Text(predictionLabel)
    //            Text(String(format: "%.1f%%", predictionConf * 100))
                Form{
                    Section(header: Text("Training")) {
                        HStack{
    //                    Text("Label")
                            Picker("Label", selection: $selectedLabel.label) {
                            ForEach(labels.labelNames, id: \.self) { i in
    //                            Text($0)
                                Text(i)
                            }
                        }
                        .disabled(labels.labelNames==[])
                        .id(id)
                        }
                        .id(id)
                        
//                        Text("You selected: \(selectedLabel.label)")
                        HStack{
                            TextField("Neues Label...", text: $newLabel)
                            Button(action: {
                                labels.addLabel(newLabel)
                                id = id + 1
                                newLabel = ""
                            }){
                                Text("Hinzufügen")
                            }
                            .disabled(!(checkLabel.checkLabel(label: newLabel)))
                            .padding(.horizontal)
                        }
                    }
                    
                }
                if(selectedLabel.label=="nothing" || selectedLabel.selectedImage==nil){
                    Text("Wähle ein Label und ein Bild aus")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                }
                if(labels.labelNames==[]){
                        Text("Füge neue Labels hinzu")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                }
                
            }
            .sheet(isPresented: $isGalleryShowing, onDismiss: nil){
                ShowGallery(selectedImage: $selectedLabel.selectedImage, isGalleryShowing: $isGalleryShowing, predictionLabel: $predictionLabel, predictionConf: $predictionConf, predict: false)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button{
                            confirmResetDialog = true
                            } label: {
                                Text("Zurücksetzen")
                            }
//                            .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 0))
                            .confirmationDialog("Model Zurücksetzen", isPresented: $confirmResetDialog, titleVisibility: .visible){
                            Button("Zurücksetzen", role: .destructive){
                                Models.deleteTrainedNearestNeighbors()
                                Models.copyEmptyNearestNeighbors()
                                labels.resetLabel()
                                id = id + 1
                                selectedLabel.label = "nothing"
                            }
                            }message: {
                                Text("Möchtest du das Model zurücksetzen?")
                            }
                            Spacer()
                            Button(action: {
                               trainNN.model = Models.loadTrainedNearestNeighbors()
                               if let cgImage = selectedLabel.selectedImage?.cgImage{
                                   trainNN.cgImage = cgImage
                               }
                               trainNN.trueLabel = selectedLabel.label
                                                        trainNN.train()
                                                    }){
                                                        Text("Trainieren")
                                                    }
                                                    .disabled(trainNN.disableButton(label: selectedLabel.label, image: selectedLabel.selectedImage))
//                                                    .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 10))
                    
                }
//                    ToolbarItem(placement: .navigationBarTrailing){
                    //                    EditButton()
                    //                }
//
            }
        }
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        TrainingView()
//        ContentView(labels: LabelsViewModel())
    }
}
