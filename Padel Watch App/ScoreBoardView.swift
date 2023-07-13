//
//  ScoreBoard.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 11/07/2023.
//

import SwiftUI

struct ScoreBoardView: View {
    var incrementScore: (TeamName) -> Void
    var currentMatch: Match
    let screenWidth = WKInterfaceDevice.current().screenBounds.width
    let screenHeight = WKInterfaceDevice.current().screenBounds.height
    
    func getScoreScreenPosition(team: TeamName) -> CGPoint{
        if team == .they {
            if currentMatch.servePosition == .right {
                return CGPoint(x: screenWidth/4*1, y:screenHeight/10*3)
            } else {
                return CGPoint(x:screenWidth/4*3, y:screenHeight/10*3)
            }
        } else {
            if currentMatch.servePosition == .right {
                return CGPoint(x:screenWidth/4*3, y:screenHeight/7*5)
            } else {
                return CGPoint(x:screenWidth/4*1, y:screenHeight/7*5)
            }
        }
        
    }
    
    
    func getScoreLabel(_ team: TeamName) -> String {
        let score = currentMatch[team].score
        if score <= 40 {
            return String(score)
        }
        return "Ad"
    }
    
    func getScoreColor(_ team: TeamName) -> Color {
        let score = currentMatch[team].score
        if score <= 40 {
            return .white
        }
        return .green
    }
    
    var body: some View {
        ZStack{
            // THEY
            Button{
                incrementScore(.they)
            }
            label: {
                HStack(alignment: .bottom){
                    Text("\(getScoreLabel(.they))")
                        .font(.system(size: 40))
                        .foregroundColor(getScoreColor(.they))
                        .frame(width: 50, height: 65)
                    Text("\(currentMatch.they.games)")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 15, height: 55)
                }
                    .frame(width: 80, height: 65)
                    .background(Color.black)
                    .cornerRadius(20)
                    .overlay(currentMatch.serveTeam == .they ? GeometryReader { gp in
                                Image(systemName:"tennisball.fill")
                                    .foregroundColor(.green)
                                    .position(x: gp.size.width/10*9, y: gp.size.height/10*1)
                        } : nil)
            }
                .position(getScoreScreenPosition(team: .they))
                .buttonStyle(PlainButtonStyle())
            // US
            Button{
                incrementScore(.us)
            }
            label: {
                HStack(alignment: .bottom){
                    Text("\(getScoreLabel(.us))")
                        .font(.system(size: 40))
                        .foregroundColor(getScoreColor(.us))
                        .frame(width: 50, height: 65)
                    Text("\(currentMatch.us.games)")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 15, height: 55)
                }
                    .frame(width: 80, height: 65)
                    .background(Color.black)
                    .cornerRadius(20)
                    .overlay(currentMatch.serveTeam == .us ? GeometryReader { gp in
                                Image(systemName:"tennisball.fill")
                                    .foregroundColor(.green)
                                    .position(x: gp.size.width/10*9, y: gp.size.height/10*1)
                        } : nil)
            }
                .position(getScoreScreenPosition(team: .us))
                .buttonStyle(PlainButtonStyle())
            
        }
    }
}
