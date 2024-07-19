//
//  Credits.swift
//  PoseRecognitionApp
//
//  Created by Bernat CS - SBP on 18/7/24.
//

import SwiftUI

struct Info: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                Text("The process is carried out locally. Your information is not shared externally.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                Spacer()
                Text("Made by ") + Text("Bernat Cucarella").bold()
                Image("logo-bernat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Spacer()
                Text("Original idea by ") + Text("Pere Vicalet").bold()
                Spacer()
            }
            .padding()
            .navigationTitle("Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    Info()
}
