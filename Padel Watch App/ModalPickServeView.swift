import SwiftUI

struct ModalPickServeView: View {
    @Binding var isPresented: Bool
    var pickServeTeam: (TeamName) -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Text("¿Quién saca primero?")
            .multilineTextAlignment(.center)
            Spacer()

            Button("Ellos") {
                isPresented.toggle()
                pickServeTeam(.they)
            }.padding(.horizontal)
            Button("Nosotros") {
                isPresented.toggle()
                pickServeTeam(.us)
            }.padding(.horizontal)
        }

       
    }
}
