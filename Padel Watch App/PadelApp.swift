//
//  PadelApp.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 11/07/2023.
//

import SwiftUI

@main
struct Padel_Watch_AppApp: App {
    var sharedData = SharedData()
    var body: some Scene {
        WindowGroup {
            PagesView().environmentObject(sharedData)
        }
    }
}
