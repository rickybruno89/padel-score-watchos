//
//  ScoreBoard.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 11/07/2023.
//

import SwiftUI

struct ScoreBoardView: View {
    @EnvironmentObject var sharedData: SharedData
    
    func getScoreScreenPosition(team: TeamName) -> CGPoint{
        if team == .they {
            if sharedData.getCurrentGame().servePosition == .right {
                return CGPoint(x: sharedData.screenWidth/4*1, y:sharedData.screenHeight/50*14)
            } else {
                return CGPoint(x:sharedData.screenWidth/4*3, y:sharedData.screenHeight/50*14)
            }
        } else {
            if sharedData.getCurrentGame().servePosition == .right {
                return CGPoint(x:sharedData.screenWidth/4*3, y:sharedData.screenHeight/50*36)
            } else {
                return CGPoint(x:sharedData.screenWidth/4*1, y:sharedData.screenHeight/50*36)
            }
        }
        
    }
    
    
    func getScoreLabel(_ team: TeamName) -> String {
        let score = sharedData.getCurrentGame()[team].score
        if score <= 40 {
            return String(score)
        }
        return "Ad"
    }
    
    func getScoreColor(_ team: TeamName) -> Color {
        let score = sharedData.getCurrentGame()[team].score
        if score <= 40 {
            return .white
        }
        return .green
    }
    
    func getGamesLabel (_ team: TeamName, _ index: Int) -> String {
        let currentSetIndex = sharedData.getCurrentGame()[team].sets.count - 1
        if(index > currentSetIndex) {
            return ""
        }
        return String(sharedData.getCurrentGame()[team].sets[index])
    }
    
    func getGamesColor (_ team: TeamName, _ index: Int) -> Color {
        let currentSetIndex = sharedData.getCurrentGame()[team].sets.count - 1
        if(index > currentSetIndex) {
            return .white
        }
        return sharedData.getCurrentGame()[team].sets[index] == 6 ? .green : .white
    }
    
    var body: some View {
        ZStack{
            // THEY SCORE
            Button{
                sharedData.incrementScore(.they)
            }
            label: {
                Text("\(getScoreLabel(.they))")
                    .font(.system(size: 24))
                    .foregroundColor(getScoreColor(.they))
                    .frame(width: 48, height: 48)
                    .background(Color.black)
                    .cornerRadius(10)
                    .overlay(sharedData.getCurrentGame().serveTeam == .they ? GeometryReader { gp in
                                Image(systemName:"tennisball.fill")
                                    .font(.system(size: 13))
                                    .foregroundColor(.green)
                                    .position(x: gp.size.width/50*42, y: gp.size.height/50*8)
                        } : nil)
            }
                .position(getScoreScreenPosition(team: .they))
                .buttonStyle(PlainButtonStyle())
            // GAMES AND SETS
            HStack(alignment: .center){
                Text("Sets (games)")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.center)
                    .frame(width: 50)
                VStack(spacing: 2.0){
                    // THEY GAMES
                    HStack(spacing: 2.0){
                        Text("\(getGamesLabel(.they,0))")
                            .font(.system(size: 13))
                            .frame(width: 14, height: 14)
                            .border(.white, width: 1)
                            .foregroundColor(getGamesColor(.they, 0))
                            .cornerRadius(1)
                        Text("\(getGamesLabel(.they,1))")
                            .font(.system(size: 13))
                            .frame(width: 14, height: 14)
                            .border(.white, width: 1)
                            .foregroundColor(getGamesColor(.they, 1))
                            .cornerRadius(1)
                        Text("\(getGamesLabel(.they,2))")
                            .font(.system(size: 13))
                            .frame(width: 14, height: 14)
                            .border(.white, width: 1)
                            .foregroundColor(getGamesColor(.they, 2))
                            .cornerRadius(1)
                    }
                    // US GAMES
                    HStack(spacing: 2.0){
                        Text("\(getGamesLabel(.us,0))")
                            .font(.system(size: 13))
                            .frame(width: 14, height: 14)
                            .border(.white, width: 1)
                            .foregroundColor(getGamesColor(.us, 0))
                            .cornerRadius(1)
                        Text("\(getGamesLabel(.us,1))")
                            .font(.system(size: 13))
                            .frame(width: 14, height: 14)
                            .border(.white, width: 1)
                            .foregroundColor(getGamesColor(.us, 1))
                            .cornerRadius(1)
                        Text("\(getGamesLabel(.us,2))")
                            .font(.system(size: 13))
                            .frame(width: 14, height: 14)
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
                sharedData.incrementScore(.us)
            }
            label: {
                Text("\(getScoreLabel(.us))")
                    .font(.system(size: 24))
                    .foregroundColor(getScoreColor(.they))
                    .frame(width: 48, height: 48)
                    .background(Color.black)
                    .cornerRadius(10)
                    .overlay(sharedData.getCurrentGame().serveTeam == .us ? GeometryReader { gp in
                                Image(systemName:"tennisball.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 13))
                                    .frame(width: 15, height: 15)
                                    .position(x: gp.size.width/50*42, y: gp.size.height/50*8)
                        } : nil)
            }
                .position(getScoreScreenPosition(team: .us))
                .buttonStyle(PlainButtonStyle())
        }
    }
}

struct ScoreBoardView_Previews: PreviewProvider {
    static var previews: some View {
          let sharedData = SharedData()
        ZStack{
            CourtView()
            ScoreBoardView()
            ActionButtonsView()
        }
              .environmentObject(sharedData)
      }
}
