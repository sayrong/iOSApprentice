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
    @State var alerIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    
    var sliderValueRounded: Int {
        Int(self.sliderValue.rounded())
    }
    
    // User interface content and layout
    var body: some View {
        VStack {
            
            Spacer()
            
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(self.target)")
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
                print("Points awarded: \(self.pointsForCurrentRound())")
                self.alerIsVisible = true
            }) {
                Text("Hit me!")
            }
            .alert(isPresented: self.$alerIsVisible) { () -> Alert in
                return Alert(title: Text("Hello there!"), message: Text(scoringMessage()), dismissButton: Alert.Button.default(Text("Awersome")))
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
    func pointsForCurrentRound() -> Int {
        var difference: Int
        if Int(self.sliderValue.rounded()) > self.target {
            difference = self.sliderValueRounded - self.target
        } else if self.target > self.sliderValueRounded {
            difference = self.target - self.sliderValueRounded
        } else {
            difference = 0
        }
        return 100 - difference
    }
    
    func scoringMessage() -> String {
        return "The slider's value is \(self.sliderValueRounded).\n" +
        "The target values is \(self.target).\n" +
        "You scored \(self.pointsForCurrentRound()) points this round."
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
