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
                return CGPoint(x: screenWidth/4*1, y:screenHeight/50*13)
            } else {
                return CGPoint(x:screenWidth/4*3, y:screenHeight/50*13)
            }
        } else {
            if currentMatch.servePosition == .right {
                return CGPoint(x:screenWidth/4*3, y:screenHeight/50*37)
            } else {
                return CGPoint(x:screenWidth/4*1, y:screenHeight/50*37)
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
    
    func getGamesLabel (_ team: TeamName, _ index: Int) -> String {
        let currentSetIndex = currentMatch[team].sets.count - 1
        if(index > currentSetIndex) {
            return ""
        }
        return String(currentMatch[team].sets[index])
    }
    
    func getGamesColor (_ team: TeamName, _ index: Int) -> Color {
        let currentSetIndex = currentMatch[team].sets.count - 1
        if(index > currentSetIndex) {
            return .white
        }
        return currentMatch[team].sets[index] == 6 ? .green : .white
    }
    
    var body: some View {
        ZStack{
            // THEY SCORE
            Button{
                incrementScore(.they)
            }
            label: {
                Text("\(getScoreLabel(.they))")
                    .font(.system(size: 35))
                    .foregroundColor(getScoreColor(.they))
                    .frame(width: 55, height: 55)
                    .background(Color.black)
                    .cornerRadius(55)
                    .overlay(currentMatch.serveTeam == .they ? GeometryReader { gp in
                                Image(systemName:"tennisball.fill")
                                    .foregroundColor(.green)
                                    .position(x: gp.size.width/10*9, y: gp.size.height/10*1)
                        } : nil)
            }
                .position(getScoreScreenPosition(team: .they))
                .buttonStyle(PlainButtonStyle())
            // GAMES AND SETS
            HStack(alignment: .center){
                Text("Sets (games)")
                    .font(.system(size: 11))
                    .multilineTextAlignment(.center)
                    .frame(width: 50)
                VStack(spacing: 2.0){
                    // THEY GAMES
                    HStack(spacing: 2.0){
                        Text("\(getGamesLabel(.they,0))")
                            .font(.system(size: 10))
                            .frame(width: 13, height: 13)
                            .border(.white, width: 1)
                            .foregroundColor(getGamesColor(.they, 0))
                            .cornerRadius(1)
                        Text("\(getGamesLabel(.they,1))")
                            .font(.system(size: 10))
                            .frame(width: 13, height: 13)
                            .border(.white, width: 1)
                            .foregroundColor(getGamesColor(.they, 1))
                            .cornerRadius(1)
                        Text("\(getGamesLabel(.they,2))")
                            .font(.system(size: 10))
                            .frame(width: 13, height: 13)
                            .border(.white, width: 1)
                            .foregroundColor(getGamesColor(.they, 2))
                            .cornerRadius(1)
                    }
                    // US GAMES
                    HStack(spacing: 2.0){
                        Text("\(getGamesLabel(.us,0))")
                            .font(.system(size: 10))
                            .frame(width: 13, height: 13)
                            .border(.white, width: 1)
                            .foregroundColor(getGamesColor(.us, 0))
                            .cornerRadius(1)
                        Text("\(getGamesLabel(.us,1))")
                            .font(.system(size: 10))
                            .frame(width: 13, height: 13)
                            .border(.white, width: 1)
                            .foregroundColor(getGamesColor(.us, 1))
                            .cornerRadius(1)
                        Text("\(getGamesLabel(.us,2))")
                            .font(.system(size: 10))
                            .frame(width: 13, height: 13)
                            .border(.white, width: 1)
                            .foregroundColor(getGamesColor(.us, 2))
                            .cornerRadius(1)
                    }
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .background(.black)
            .cornerRadius(5)
            // US SCORE
            Button{
                incrementScore(.us)
            }
            label: {
                Text("\(getScoreLabel(.us))")
                    .font(.system(size: 35))
                    .foregroundColor(getScoreColor(.us))
                    .frame(width: 55, height: 55)
                    .background(Color.black)
                    .cornerRadius(55)
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

struct ScoreBoardView_Previews: PreviewProvider {
    static var previews: some View {
        var match: Match = Match(they: Team(score: 0,  sets: [0]), us: Team(score: 0,  sets: [0]), serveTeam: .they, servePosition: .right)
        ZStack{
            CourtView()
            ScoreBoardView(incrementScore: { _ in }, currentMatch: match)
        }
    }
}
