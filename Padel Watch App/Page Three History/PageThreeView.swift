//
//  Tab3.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 14/07/2023.
//

import SwiftUI

struct PageThreeView: View {
    @EnvironmentObject var sharedData: SharedData
    @State var isShowingDialog = false
    
    var body: some View {
        ScrollView{
            VStack{
                Button("Nueva partida") {
                    isShowingDialog = true
                }.padding(.horizontal)
                .background(.red)
                .cornerRadius(20)
                .confirmationDialog(
                    "¿Desea finalizar la partida actual y comenzar una nueva?",
                    isPresented: $isShowingDialog
                ) {
                    Button("Finalizar partida", role: .destructive) {
                        sharedData.newMatch()
                        sharedData.selectedTab = 1
                    }.padding(.horizontal).cornerRadius(20)
                    Button("Cancelar", role: .cancel) {}
                }
                HistoryView().padding(.top, 10).padding(.bottom, 30)
            }
            .padding(.top, 10)
            .background(.black)
            .frame(width: sharedData.screenWidth)
        }
    }
}

