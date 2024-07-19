//
//  ContentView.swift
//  PoseRecognitionApp
//
//  Created by Bernat CS on 18/7/24.
//

import SwiftUI


struct HomeView: View {
    @State private var showCredits = false
    @State private var showConfig = false
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: Instr_Piano()) {
                    Text("Piano")
                }
                NavigationLink(destination: Instr_Clarinet()) {
                    Text("Clarinet")
                }
                NavigationLink(destination: Instr_Composer()) {
                    Text("Composer")
                }
            }
            .navigationTitle("Instruments")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showCredits = true
                    }) {
                        Image(systemName: "info.circle")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showConfig = true
                    }) {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showCredits) {
                Info()
            }
            .sheet(isPresented: $showConfig) {
                Config()
            }
        }
    }
}
    
#Preview {
    HomeView()
}
