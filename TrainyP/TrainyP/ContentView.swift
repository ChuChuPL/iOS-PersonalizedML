//
//  ContentView.swift
//  TrainyP
//
//  Created by Linh Chu on 23.04.23.
//

import SwiftUI

struct ContentView: View {
    var trainNN = TrainNearestNeighborsViewController()
    var checkLabel = CheckLabel()
//    @ObservedObject var labels: LabelsViewModel
    @State var id = 0
    @State var newLabel = ""
    @State var isGalleryShowing = false
    @State var selectedImage: UIImage?
    @State var predictionLabel = "?"
    @State var predictionConf = 0.0
    @State var selectedLabel: String = "nothing"
    var flavors: [String] = ["test1", "test2", "test3"]
    var noLabel = "Please add a label"
    var nothingSelected = "nothing"
    
    var body: some View {
        VStack{
            if selectedImage != nil{
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            HStack{
//                Button{
//                }label:{
//                    Text("test")
//                }
//                .padding(.horizontal)
                Button{
                    //show the image picker
                    isGalleryShowing = true
                    id = id + 1
                }label:{
                    Text("Select a Photo")
                }
            }
            Text(predictionLabel)
            Text(String(predictionConf))
            HStack{
                TextField("New Label", text: $newLabel)

                                .textFieldStyle(.roundedBorder)
                                .padding(.leading)
                Button(action: {
                    labels.addLabel(newLabel)
                    id = id + 1
                    newLabel = ""
                }){
                    Text("Add Label")
                }
                .disabled(!(checkLabel.checkLabel(label: newLabel)))
                .padding(.horizontal)
            }
            HStack{
                Text("Label")
                Picker("Please choose Label", selection: $selectedLabel) {
                    ForEach(labels.labelNames, id: \.self) {
                        Text($0)
                    }
                }
                .id(id)
                Button(action: {
                    trainNN.model = Models.loadTrainedNearestNeighbors()
                    if let cgImage = selectedImage?.cgImage{
                        trainNN.cgImage = cgImage
                    }
                    trainNN.trueLabel = selectedLabel
                    trainNN.train()
                }){
                    Text("Train")
                }
                .disabled(trainNN.disableButton(label: selectedLabel, image: selectedImage))
                .padding(.horizontal)
            }
            if(selectedLabel==noLabel){
                Text("You selected: \(nothingSelected)")
            }else{
                Text("You selected: \(selectedLabel)")
            }
            Button(action: {
                Models.deleteTrainedNearestNeighbors()
                            Models.copyEmptyNearestNeighbors()
                labels.resetLabel()
                id = id + 1
            }){
                Text("Reset")
            }
//            Models.deleteTrainedNearestNeighbors()
//            Models.copyEmptyNearestNeighbors()
                        
//            Picker(selection: $selectedFlavor,
//                   label: HStack{
//                Text("Flavor:")
//                Text(selectedFlavor)
//                }
//                .font(.headline)
//                .padding()
//                .foregroundColor(.white)
//                .background(Color.black)
//                   ,
//                content: {
//                ForEach(flavors, id: \.self) { flavor in
//                    Text(flavor)
//                        .tag(flavor)
//                }
//            })
//            .pickerStyle(MenuPickerStyle())
            
        }
        .sheet(isPresented: $isGalleryShowing, onDismiss: nil){
            ShowGallery(selectedImage: $selectedImage, isGalleryShowing: $isGalleryShowing, predictionLabel: $predictionLabel, predictionConf: $predictionConf)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        ContentView(labels: LabelsViewModel())
    }
}
