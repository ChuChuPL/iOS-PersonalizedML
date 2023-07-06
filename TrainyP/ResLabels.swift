//
//  ResLabels.swift
//  TrainyP
//
//  Created by Linh Chu on 01.07.23.
//

import Foundation

class ResLabels{
    var label : String
    var right: [Int]
    var countTest: [Int]
    var countTrain: [Int]
    
    init(){
        label = ""
        right = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        countTest = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        countTrain = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    }
}

