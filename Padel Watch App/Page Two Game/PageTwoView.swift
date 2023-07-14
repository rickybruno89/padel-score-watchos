//
//  ContentView.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 11/07/2023.
//

import SwiftUI



struct PageTwoView: View {
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
            ZStack{
                CourtView()
                ScoreBoardView()
                ActionButtonsView()
            }
    }
}

struct PageTwoView_Previews: PreviewProvider {
    static var previews: some View {
          let sharedData = SharedData()
          PageTwoView()
              .environmentObject(sharedData)
      }
}
