//
//  ContentView.swift
//  Bullseye
//
//  Created by Dmitriy on 21/10/2019.
//  Copyright © 2019 Dmitriy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // Properties
    // ==========
    
    //User interface views
    @State var alerIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    
    // User interface content and layout
    var body: some View {
        VStack {
            
            Spacer()
            
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("100")
            }
            
            Spacer()
            
            // Slider row
            HStack {
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            
            Spacer()
            
            // Button row
            Button(action: {
                print("Button pressed")
                self.alerIsVisible = true
            }) {
                Text("Hit me!")
            }
            .alert(isPresented: self.$alerIsVisible) { () -> Alert in
                return Alert(title: Text("Hello there!"), message: Text("The slider's value is \(Int(self.sliderValue.rounded()))"), dismissButton: Alert.Button.default(Text("Awersome")))
            }
            
            Spacer()
            
            // Score row
            // TODO: Add view for the score rounds and start and info buttons
            HStack {
                Button(action: {}) {
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
                Text("999999")
                Spacer()
                Text("Round")
                Text("999")
                Spacer()
                Button(action: {}) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    // Methods
    // =======
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
