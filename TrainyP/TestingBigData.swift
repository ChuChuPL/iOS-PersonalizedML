//
//  TestingBigData.swift
//  TrainyP
//
//  Created by Linh Chu on 01.07.23.
//
import Foundation
import UIKit
import CoreML
import Vision

class TestingBigData{
    var labelNames: [String] = ["chichi200", "FeiFei"]
    var res: [ResLabels] = []
    var countRight=0
    var count=0
    var trainCount = 0
    
    private func fileURLs(at url: URL) -> [URL] {
        contentsOfDirectory(at: url)!
    }
    //180*label*10
    func testingRes(){
        self.count = 0
        self.countRight = 0
        Models.deleteTrainedNearestNeighbors()
        Models.copyEmptyNearestNeighbors()
//        TestData(data: "train")
//        TestData(data: "test")
        TestData()
//        print("startTesting")
        for label in self.res{
            var index = 0
            print(labelNames[index])
            print("amount of right Counts(?x10)")
            for rightCount in label.right{
                print(rightCount)
            }
            print("number of Test data(20x10)")
            for allTest in label.countTest{
                print(allTest)
            }
            print("number of Train Data(180x10)")
            for allTrain in label.countTrain{
                print(allTrain)
            }
            index+=1
        }
//        print(self.countRight)
//
//        print(self.count)
    }
    
    func TestData() {
//        print("bundle")
      guard let baseURL = Bundle.main.url(forResource: "Dataset",
                                          withExtension: nil/*,
                                          subdirectory: "Dataset"*/) else {
        fatalError("Error: built-in dataset not found")
      }
        for i in 0...9{
            self.res.append(ResLabels())
            Models.deleteTrainedNearestNeighbors()
            Models.copyEmptyNearestNeighbors()
            for i2 in 0...1{
                
                var indexLabel = 0
      for label in labelNames{
          trainCount=0
          var indexPic = 0
//          let testMin = 20
          let testMin = i*20
          let testMax = testMin+20-1
          for fromURL in fileURLs(at: baseURL.appendingPathComponent(label)) {
//            if(indexPic>=80){
//                break
//            }
//            print("fromURLWorking")
//          let filename = fromURL.lastPathComponent
//            print(fromURL)
            if let image = UIImage(contentsOfFile: fromURL.path){
//                if(data=="train"){
//                    train(image: image, label: label)
//                }
//                if(data=="test"){
//                    test(image: image, label: label)
//                }
                if((indexPic<testMin || indexPic>testMax) && i2==0){
                    train(image: image, label: label)
                    trainCount+=1
//                    print("train")
                }
                if(indexPic>=testMin && indexPic<=testMax && i2==1){
                    test(image: image, label: label)
//                    print("test")
                }
//
                indexPic+=1
            }
//          let toURL = imageURL(for: label, filename: filename)
//          if copyIfNotExists(from: fromURL, to: toURL) {
//            examples.append((filename, label))
          }
//        }
          if(i2==0){
              self.res[indexLabel].countTrain[i] = self.trainCount
          }
          if(i2==1){
              self.res[indexLabel].right[i] = self.countRight
              self.res[indexLabel].countTest[i] = self.count
              self.count = 0
              self.countRight = 0
          }
          indexLabel+=1
      }
      }
        }
    }
    
    func test(image: UIImage, label: String){
        print("test")
//        DispatchQueue.main.async{
            self.count+=1
//            print(self.count)
                let model = Models.loadTrainedNearestNeighbors()
                let predictor = Predictor(model: model!)
                let imageOptions: [MLFeatureValue.ImageOption: Any] = [
                  .cropAndScale: VNImageCropAndScaleOption.scaleFill.rawValue
                ]
                let featureValue = try? MLFeatureValue(cgImage:                                      image.cgImage!, constraint: imageConstraint(model: model!), options: imageOptions)
                let prediction = predictor.predict(image: featureValue!)
            let predictionLabel = prediction!.label
        print(predictionLabel)
        print(label)
//                var predictionConf = prediction!.confidence
            if(predictionLabel==label){
                self.countRight+=1
                print(self.countRight)
            }
//        }
    }
    
    func train(image: UIImage, label: String){
        print("train")
        trainNN.model = Models.loadTrainedNearestNeighbors()
        if let cgImage = image.cgImage{
            trainNN.cgImage = cgImage
        }
        trainNN.trueLabel = label
        trainNN.train()
    }
}

