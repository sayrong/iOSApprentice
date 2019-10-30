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
    
    // Colors
    let midnightBlue = Color(red: 0, green: 0.2, blue: 0.4)
    
    //User interface views
    @State var alerIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    var sliderValueRounded: Int {
        Int(sliderValue.rounded())
    }
    
    var sliderTargetDifference: Int {
        abs(sliderValueRounded - self.target)
    }
    
    // User interface content and layout
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                // Target row
                HStack {
                    Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                    Text("\(target)").modifier(ValueStyle())
                }
                
                Spacer()
                
                // Slider row
                HStack {
                    Text("1").modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                        .accentColor(Color.green)
                    Text("100").modifier(LabelStyle())
                }
                
                Spacer()
                
                // Button row
                Button(action: {
                    self.alerIsVisible = true
                }) {
                    Text("Hit me!").modifier(ButtonLargeTextStyle())
                }
            .background(Image("Button")
            .modifier(Shadow())
            )
                .alert(isPresented: self.$alerIsVisible) { () -> Alert in
                    return Alert(title: Text(alertTitle()), message: Text(scoringMessage()), dismissButton: Alert.Button.default(Text("Awersome")) {
                        self.startNewRound()
                    } )
                }
                
                Spacer()
                
                // Score row
                // TODO: Add view for the score rounds and start and info buttons
                HStack {
                    Button(action: {
                        self.startNewGame()
                    }) {
                        HStack {
                            Image("StartOverIcon")
                            Text("Start over").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button")
                    .modifier(Shadow())
                    )
                    Spacer()
                    Text("Score:").modifier(LabelStyle())
                    Text("\(score)").modifier(ValueStyle())
                    Spacer()
                    Text("Round").modifier(LabelStyle())
                    Text("\(round)").modifier(ValueStyle())
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image("InfoIcon")
                            Text("Info").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button")
                    .modifier(Shadow())
                    )
                }
                .padding(.bottom, 20)
                .accentColor(midnightBlue)
            }
            .onAppear() {
                self.startNewGame()
            }
            .background(Image("Background"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Methods
    // =======
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let points: Int
        if sliderTargetDifference == 0 {
            points = 200
        } else if sliderTargetDifference == 1 {
            points = 150
        } else {
            points = maximumScore - sliderTargetDifference
        }
        return points
    }
    
    func scoringMessage() -> String {
        return "The slider's value is \(sliderValueRounded).\n" +
        "The target values is \(target).\n" +
        "You scored \(pointsForCurrentRound()) points this round."
    }
    
    func alertTitle() -> String {
        let title: String
        if sliderTargetDifference == 0 {
            title = "Perfect!"
        } else if sliderTargetDifference < 5 {
            title = "You almost had it!"
        } else if sliderTargetDifference <= 10 {
            title = "Nod bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func startNewGame() {
        score = 0
        round = 1
        resetSliderAndTarget()
    }
    
    func startNewRound() {
        score = score + pointsForCurrentRound()
        round = round + 1
        resetSliderAndTarget()
    }
    
    func resetSliderAndTarget() {
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
    }
    
}

// View modifiers
// ===============

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(Color.white)
            .modifier(Shadow())
    }
}

struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
            .foregroundColor(Color.yellow)
            .modifier(Shadow())
    }
}

struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
}

struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(Color.black)
    }
}

struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
            .foregroundColor(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
