//
//  ContentView.swift
//  Bullseye
//
//  Created by Dmitriy on 21/10/2019.
//  Copyright © 2019 Dmitriy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alerIsVisible: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to SwiftUI")
                .fontWeight(.black)
                .foregroundColor(.green)
            Button(action: {
                print("Button pressed")
                self.alerIsVisible = true
            }) {
                Text("Hit me!")
            }
            .alert(isPresented: self.$alerIsVisible) { () -> Alert in
                return Alert(title: Text("Hello there!"), message: Text("Pop-up text"), dismissButton: Alert.Button.default(Text("Awersome")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
