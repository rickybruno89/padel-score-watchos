//
//  ContentView.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 11/07/2023.
//

import SwiftUI

enum ServePosition: String {
    case left, right
}

enum TeamName: String {
    case they, us
}

struct Team {
    var score: Int
    var games: Int
}

struct Match {
    var they: Team
    var us: Team
    var serveTeam: TeamName
    var servePosition: ServePosition
    
    mutating func updateTeam(for team: TeamName, score: Int, games: Int? = nil) {
        switch team {
        case .they:
            they.score = score
            if let games = games {
                they.games = games
            }
        case .us:
            us.score = score
            if let games = games {
                us.games = games
            }
        }
    }
    
    subscript(team: TeamName) -> Team {
        switch team {
        case .they:
            return they
        case .us:
            return us
        }
    }
    
}

struct ContentView: View {
    let screenWidth = WKInterfaceDevice.current().screenBounds.width
    let screenHeight = WKInterfaceDevice.current().screenBounds.height
    @State var matchesIndex = 0
    @State var matches: [Match] = [Match(they: Team(score: 0, games: 0), us: Team(score: 0, games: 0), serveTeam: .they, servePosition: .right)]
    @State private var isPresentingModalView = true
    @State private var isShowingDialog = false
    
    func incrementScore(team: TeamName){
        let currentMatch = getCurrentGame()
        var nextMatch = getCurrentGame()
        let otherTeam: TeamName = team == .they ? .us : .they
        
        switch currentMatch[team].score {
            case 0:
                nextMatch.updateTeam(for: team, score: 15)
                nextMatch.servePosition = getNewServePosition()
                WKInterfaceDevice.current().play(.notification)
            case 15:
                nextMatch.updateTeam(for: team, score: 30)
                nextMatch.servePosition = getNewServePosition()
                WKInterfaceDevice.current().play(.notification)
            case 30:
                nextMatch.updateTeam(for: team, score: 40)
                nextMatch.servePosition = getNewServePosition()
                WKInterfaceDevice.current().play(.notification)
            case 40:
                switch currentMatch[otherTeam].score {
                    case 40:
                        nextMatch.updateTeam(for: team, score: 55)
                        nextMatch.servePosition = getNewServePosition()
                        WKInterfaceDevice.current().play(.notification)
                    case 55:
                        nextMatch.updateTeam(for: otherTeam, score: 40)
                        nextMatch.servePosition = getNewServePosition()
                        WKInterfaceDevice.current().play(.notification)
                    default:
                        nextMatch.updateTeam(for: team, score: 0, games: nextMatch[team].games+1)
                        nextMatch.updateTeam(for: otherTeam, score: 0)
                        nextMatch.serveTeam = getNewTeamServe()
                        nextMatch.servePosition = .right
                        WKInterfaceDevice.current().play(.success)
                }
            case 55:
                nextMatch.updateTeam(for: team, score: 0, games: nextMatch[team].games+1)
                nextMatch.updateTeam(for: otherTeam, score: 0)
                nextMatch.serveTeam = getNewTeamServe()
                nextMatch.servePosition = .right
                WKInterfaceDevice.current().play(.success)
            default:
                break
        }
        incrementMatchesIndex()
        matches.append(nextMatch)
    }
    
    func getCurrentTeam(_ team: TeamName) -> Team{
        let currentGame = getCurrentGame()
        if team == .they {
            return currentGame.they
        } else {
            return currentGame.us
        }
    }
    
    func getOtherTeam(_ team: TeamName) -> Team{
        let currentGame = getCurrentGame()
        if team == .they {
            return currentGame.us
        } else {
            return currentGame.they
        }
    }
        
    func getNewServePosition()-> ServePosition {
        let currentGame = getCurrentGame()
        return currentGame.servePosition == .left ? .right : .left
    }
    
    func getNewTeamServe()-> TeamName {
        let currentGame = getCurrentGame()
        return currentGame.serveTeam == .they ? .us : .they
    }
    
    func incrementMatchesIndex() {
        let removeFromIndex = matchesIndex + 1
        if removeFromIndex < matches.count  {
            let rangeToRemove = removeFromIndex...(matches.count - 1)
            matches.removeSubrange(rangeToRemove)
        }
        matchesIndex += 1
    }
    
    func getCurrentGame() -> Match {
        return matches[matchesIndex]
    }
    
    func pickServeTeam(team: TeamName){
        matches[matchesIndex].serveTeam = team
    }
    
    func newMatch() {
        matchesIndex = 0
        matches = [Match(they: Team(score: 0, games: 0), us: Team(score: 0, games: 0), serveTeam: .they, servePosition: .right)]
        isPresentingModalView = true
    }
    
    func undo() {
        if matchesIndex >= 1 {
            matchesIndex -= 1
        }
    }
        
    func redo() {
        if matchesIndex < (matches.count - 1) {
            matchesIndex += 1
        }
    }
    
    var body: some View {
        ScrollView{
            ZStack{
                CourtView()
                ScoreBoardView(incrementScore: { team in self.incrementScore(team: team) }, currentMatch: getCurrentGame())
               ActionButtonsView(undo: { self.undo() }, redo: { self.redo() })
            }
            VStack{
                Button("Nueva partida") {
                    isShowingDialog = true
                }
                .background(.red)
                .cornerRadius(20)
                .confirmationDialog(
                    "¿Desea finalizar la partida actual y comenzar una nueva partida?",
                    isPresented: $isShowingDialog
                ) {
                    Button("Finalizar partida", role: .destructive) {
                        newMatch()
                    }
                    Button("Cancelar", role: .cancel) {}
                }
                HistoryView(matches: matches).padding(.top, 10).padding(.bottom, 30)
            }
            .padding(.top, 10)
            .background(.black).frame(width: screenWidth)
            .fullScreenCover(isPresented: $isPresentingModalView) {
                ModalPickServeView(isPresented: $isPresentingModalView, pickServeTeam: { team in self.pickServeTeam(team: team) }).navigationBarHidden(true)
            }
        }.navigationBarHidden(true).ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
