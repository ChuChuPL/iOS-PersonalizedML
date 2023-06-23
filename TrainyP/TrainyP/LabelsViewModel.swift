//
//  LabelsViewModel.swift
//  TrainyP
//
//  Created by Linh Chu on 31.05.23.
//

import SwiftUI

class LabelsViewModel: ObservableObject{
    @Published private var selectedLabel = LabelModel()
    @Published  var selectedImage : UIImage?
    @Published var predictionLabel = "?"
    @Published var predictionConf = 0.0
    
    var label: String {
        get {
            selectedLabel.label
        }
        set{
            selectedLabel.label = newValue
        }
    }
    
    init() {
      readSelectedLabel()
    }

    private var selectedLabelURL: URL {
      applicationDocumentsDirectory.appendingPathComponent("selectedLabel.json")
    }

    private func readSelectedLabel() {
      do {
        let data = try Data(contentsOf: selectedLabelURL)
        label = try JSONDecoder().decode(String.self, from: data)
          print("reading")
      } catch {
          label = selectedLabel.label
      }
    }

    func saveSelectedLabel() {
      do {
        let data = try JSONEncoder().encode(label)
        try data.write(to: selectedLabelURL)
  //        self.pickerId += 1
          print("saving")
      } catch {
        print("Error: \(error)")
      }
    }
    
//    func addLabel(label: String){
//        updateLabels.addLabel(label)
//    }
}


