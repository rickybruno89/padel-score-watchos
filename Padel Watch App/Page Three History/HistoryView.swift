//
//  HistoryView.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 11/07/2023.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var sharedData: SharedData
    
    func getScoreLabel(score: Int) -> String {
        if score <= 40 {
            return String(score)
        }
        return "Ad"
    }
    
    var body: some View {
        VStack {
            Text("Historial")
                .font(.headline)
                .foregroundColor(.white)
            Image(systemName:"figure.tennis")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.green)
                .frame(width: 25, height: 25)
            ForEach(sharedData.matches.indices, id: \.self) { index in
                let match = sharedData.matches[index]
                Divider().background(Color.white.frame(height: 2))
                HStack(alignment: .bottom){
                    VStack(alignment: .center){
                        Text("Ellos").foregroundColor(match.serveTeam == .they ? .green : .white)
                        Text("\(getScoreLabel(score: match.they.score))")
                        Text("\(match.they.sets[0])")
                    }
                    VStack(alignment: .center){
                        Text("Puntos")
                        Text("Games")
                    }
                    VStack(alignment: .center){
                        Text("Nos.").foregroundColor(match.serveTeam == .us ? .green : .white)
                        Text("\(getScoreLabel(score: match.us.score))")
                        Text("\(match.us.sets[0])")
                    }
                }
            }
            Divider().background(Color.white.frame(height: 2))
        }
    }
}
