//
//  ContentView.swift
//  TrainyP
//
//  Created by Linh Chu on 23.04.23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @ObservedObject var selectedLabel: LabelsViewModel
    
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
