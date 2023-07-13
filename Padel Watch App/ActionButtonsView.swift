//
//  ActionButtonsView.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 11/07/2023.
//

import SwiftUI

struct ActionButtonsView: View {
    var undo: () -> Void
    var redo: () -> Void
    let screenWidth = WKInterfaceDevice.current().screenBounds.width
    let screenHeight = WKInterfaceDevice.current().screenBounds.height
    
    var body: some View {
        ZStack{
            HStack{
                Button{
                    undo()
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
                    .position(x:screenWidth/10*4, y:screenHeight/100*94)
                    .buttonStyle(PlainButtonStyle())
                Button{
                    redo()
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
                .position(x:screenWidth/10, y:screenHeight/100*94)
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
