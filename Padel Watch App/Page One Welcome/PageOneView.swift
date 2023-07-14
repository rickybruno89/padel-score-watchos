import SwiftUI

struct PageOneView: View {
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        VStack {
            Spacer()
            Text("¿Que equipo saca?")
            .multilineTextAlignment(.center)
            Spacer()
            Button("Ellos") {
                sharedData.pickServeTeam(.they)
            }.padding(.horizontal)
            Button("Nosotros") {
                sharedData.pickServeTeam(.us)
            }.padding(.horizontal)
        }
    }
}
