//
//  SharedData.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 14/07/2023.
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
    var sets: [Int]
}

struct Match {
    var they: Team
    var us: Team
    var serveTeam: TeamName
    var servePosition: ServePosition
    
    mutating func updateTeamScore(for team: TeamName, score: Int) {
        switch team {
        case .they:
            they.score = score
        case .us:
            us.score = score
        }
    }
    
    mutating func updateTeamSets(for team: TeamName, sets: [Int]) {
        switch team {
        case .they:
            they.sets = sets
        case .us:
            us.sets = sets
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

class SharedData: ObservableObject {
    @Published var selectedTab = 1
    @Published var screenWidth = WKInterfaceDevice.current().screenBounds.width
    @Published var screenHeight = WKInterfaceDevice.current().screenBounds.height
    @Published var matchesIndex = 0
    @Published var matches: [Match] = [Match(they: Team(score: 0, sets: [0]), us: Team(score: 0, sets: [0]), serveTeam: .they, servePosition: .right)]
    
    func incrementScore(_ team: TeamName){
        let currentMatch = getCurrentGame()
        var nextMatch = getCurrentGame()
        let otherTeam: TeamName = team == .they ? .us : .they
        
        switch currentMatch[team].score {
            case 0:
                nextMatch.updateTeamScore(for: team, score: 15)
                nextMatch.servePosition = getNewServePosition()
                WKInterfaceDevice.current().play(.notification)
            case 15:
                nextMatch.updateTeamScore(for: team, score: 30)
                nextMatch.servePosition = getNewServePosition()
                WKInterfaceDevice.current().play(.notification)
            case 30:
                nextMatch.updateTeamScore(for: team, score: 40)
                nextMatch.servePosition = getNewServePosition()
                WKInterfaceDevice.current().play(.notification)
            case 40:
                switch currentMatch[otherTeam].score {
                    case 40:
                        nextMatch.updateTeamScore(for: team, score: 55)
                        nextMatch.servePosition = getNewServePosition()
                        WKInterfaceDevice.current().play(.notification)
                    case 55:
                        nextMatch.updateTeamScore(for: otherTeam, score: 40)
                        nextMatch.servePosition = getNewServePosition()
                        WKInterfaceDevice.current().play(.notification)
                    default:
                        nextMatch.updateTeamScore(for: team, score: 0)
                        nextMatch.updateTeamScore(for: otherTeam, score: 0)
                        nextMatch.serveTeam = getNewTeamServe()
                        nextMatch.servePosition = .right
                        let currentTeamSetsIndex = currentMatch[team].sets.count - 1
                        var nextTeamSets = currentMatch[team].sets
                        nextTeamSets[currentTeamSetsIndex] += 1
                        nextMatch.updateTeamSets(for: team, sets: nextTeamSets)
                        if(nextTeamSets[currentTeamSetsIndex] == 6) {
                            var newTeamSetsTemp = nextTeamSets
                            var newOtherTeamSets = currentMatch[otherTeam].sets
                            newTeamSetsTemp.append(0)
                            print(newTeamSetsTemp)
                            newOtherTeamSets.append(0)
                            nextMatch.updateTeamSets(for: team, sets: newTeamSetsTemp)
                            nextMatch.updateTeamSets(for: otherTeam, sets: newOtherTeamSets)
                        }
                        WKInterfaceDevice.current().play(.success)
                }
            case 55:
                nextMatch.updateTeamScore(for: team, score: 0)
                nextMatch.updateTeamScore(for: otherTeam, score: 0)
                nextMatch.serveTeam = getNewTeamServe()
                nextMatch.servePosition = .right
                let currentTeamSetsIndex = currentMatch[team].sets.count - 1
                var nextTeamSets = currentMatch[team].sets
                nextTeamSets[currentTeamSetsIndex] += 1
                nextMatch.updateTeamSets(for: team, sets: nextTeamSets)
                if(nextTeamSets[currentTeamSetsIndex] == 6) {
                    var newTeamSetsTemp = nextTeamSets
                    var newOtherTeamSets = currentMatch[otherTeam].sets
                    newTeamSetsTemp.append(0)
                    print(newTeamSetsTemp)
                    newOtherTeamSets.append(0)
                    nextMatch.updateTeamSets(for: team, sets: newTeamSetsTemp)
                    nextMatch.updateTeamSets(for: otherTeam, sets: newOtherTeamSets)
                }
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
    
    func pickServeTeam(_ team: TeamName){
        matches[matchesIndex].serveTeam = team
        selectedTab = 2
    }
    
    func newMatch() {
        matchesIndex = 0
        matches = [Match(they: Team(score: 0, sets: [0]), us: Team(score: 0,  sets: [0]), serveTeam: .they, servePosition: .right)]
        // TODO navegar a la view esa
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
    
}

