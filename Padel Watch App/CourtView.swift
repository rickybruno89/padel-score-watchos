//
//  CourtView.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 11/07/2023.
//

import SwiftUI

struct CourtView: View {
    let screenWidth = WKInterfaceDevice.current().screenBounds.width
    let screenHeight = WKInterfaceDevice.current().screenBounds.height
    
    var body: some View {
        ZStack{
            // LINES
            ZStack{
                // TOP LINE
                Rectangle()
                    .frame(width: screenWidth, height: 2)
                    .foregroundColor(.white)
                    .position(x: screenWidth/2, y: screenHeight/8*1)
                // BOTTOM LINE
                Rectangle()
                    .frame(width: screenWidth, height: 2)
                    .foregroundColor(.white)
                    .position(x: screenWidth/2, y: screenHeight/8*7)
                // VERTICAL CENTRAL LINE
                Rectangle()
                    .frame(width: 2, height: screenHeight/8*6)
                    .foregroundColor(.white)
            }
            // NET
            ZStack{
                Rectangle()
                    .frame(width: screenWidth, height: 2)
                    .foregroundColor(.black)
                    .position(x: screenWidth/2, y: screenHeight/8*4-8)
                Rectangle()
                    .frame(width: screenWidth, height: 0.5)
                    .foregroundColor(.black)
                    .position(x: screenWidth/2, y: screenHeight/8*4-6)
                Rectangle()
                    .frame(width: screenWidth, height: 0.5)
                    .foregroundColor(.black)
                    .position(x: screenWidth/2, y: screenHeight/8*4-4)
                Rectangle()
                    .frame(width: screenWidth, height: 0.5)
                    .foregroundColor(.black)
                    .position(x: screenWidth/2, y: screenHeight/8*4-2)
                Rectangle()
                    .frame(width: screenWidth, height: 0.5)
                    .foregroundColor(.black)
                    .position(x: screenWidth/2, y: screenHeight/8*4)
                Rectangle()
                    .frame(width: screenWidth, height: 0.5)
                    .foregroundColor(.black)
                    .position(x: screenWidth/2, y: screenHeight/8*4+2)
                Rectangle()
                    .frame(width: screenWidth, height: 0.5)
                    .foregroundColor(.black)
                    .position(x: screenWidth/2, y: screenHeight/8*4+4)
                Rectangle()
                    .frame(width: screenWidth, height: 0.5)
                    .foregroundColor(.black)
                    .position(x: screenWidth/2, y: screenHeight/8*4+6)
                Rectangle()
                    .frame(width: screenWidth, height: 0.5)
                    .foregroundColor(.black)
                    .position(x: screenWidth/2, y: screenHeight/8*4+8)
                Rectangle()
                    .frame(width: screenWidth, height: 0.5)
                    .foregroundColor(.black)
                    .position(x: screenWidth/2, y: screenHeight/8*4+10)
            }
        }
        .frame(width: screenWidth, height: screenHeight)
        .background(.blue)
    }
}

struct CourtView_Previews: PreviewProvider {
    static var previews: some View {
        CourtView()
    }
}
