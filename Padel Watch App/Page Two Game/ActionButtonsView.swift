//
//  ActionButtonsView.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 11/07/2023.
//

import SwiftUI

struct ActionButtonsView: View {
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        ZStack{
            HStack{
                Button{
                    sharedData.undo()
                    WKInterfaceDevice.current().play(.directionDown)
                } label: {
                    Image(systemName: "arrow.uturn.left")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .frame(width: 22, height: 22)
                        .background(Color.black)
                        .cornerRadius(22)
                        .padding()
                }
                .position(x:sharedData.screenWidth/10*4, y:sharedData.screenHeight/100*6)
                    .buttonStyle(PlainButtonStyle())
                Button{
                    sharedData.redo()
                    WKInterfaceDevice.current().play(.directionUp)
                } label: {
                    Image(systemName: "arrow.uturn.right")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .frame(width: 22, height: 22)
                        .background(Color.black)
                        .cornerRadius(22)
                        .padding()
                }
                .position(x:sharedData.screenWidth/10, y:sharedData.screenHeight/100*6)
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
