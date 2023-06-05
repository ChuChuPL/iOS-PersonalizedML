//
//  LabelsViewModel.swift
//  TrainyP
//
//  Created by Linh Chu on 31.05.23.
//

import SwiftUI

class LabelsViewModel: ObservableObject{
    @Published private var updateLabels = Labels()
    
    var labels: [String] {
        get {
            updateLabels.labelNames
        }
    }
    
    func addLabel(label: String){
        updateLabels.addLabel(label)
    }
}


