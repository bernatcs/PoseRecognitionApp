//
//  Credits.swift
//  PoseRecognitionApp
//
//  Created by Bernat CS - SBP on 18/7/24.
//

import SwiftUI

struct Credits: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Text("Esta es la vista de Credits")
                .navigationTitle("Credits")
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
    Credits()
}
