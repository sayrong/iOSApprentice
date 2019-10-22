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
    
    // User interface content and layout
    var body: some View {
        VStack {
            
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("100")
            }
            
            // Slider row
            HStack {
                Text("1")
                Slider(value: .constant(10))
                Text("100")
            }
            
            // Button row
            Button(action: {
                print("Button pressed")
                self.alerIsVisible = true
            }) {
                Text("Hit me!")
            }
            .alert(isPresented: self.$alerIsVisible) { () -> Alert in
                return Alert(title: Text("Hello there!"), message: Text("Pop-up text"), dismissButton: Alert.Button.default(Text("Awersome")))
            }
            
            // Score row
            // TODO: Add view for the score
            
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
