//
//  ContentView.swift
//  crud
//
//  Created by Erick Martins on 02/02/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    init() {
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        Home()
    }
}
