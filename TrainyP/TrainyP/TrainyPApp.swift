//
//  TrainyPApp.swift
//  TrainyP
//
//  Created by Linh Chu on 23.04.23.
//

import SwiftUI

@main
struct TrainyPApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var labelsViewModel = LabelsViewModel()
    var body: some Scene {
        WindowGroup {
//            ContentView()
            ContentView(selectedLabel: labelsViewModel)
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        labelsViewModel.saveSelectedLabel()
                    }
                }
            /*Environment(\.scenePhase) private var scenePhase var iconViewModel = IconsViewModel()
             var body: some Scene { WindowGroup {
             MasterView(iconViewModel: iconViewModel) .onChange(of: scenePhase) { phase in
              Auf Änderungen achten
             if phase == .inactive { iconViewModel.saveModel()*/
        }
    }
}
