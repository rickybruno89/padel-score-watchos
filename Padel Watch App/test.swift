//
//  test.swift
//  Padel Watch App
//
//  Created by Ricky Bruno on 11/07/2023.
//

import SwiftUI

struct test: View {
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
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
