//
//  PoseRecognitionAppApp.swift
//  PoseRecognitionApp
//
//  Created by Bernat CS on 18/7/24.
//

import SwiftUI
import AVFoundation

@main
struct PoseRecognitionAppApp: App {
    var body: some Scene {
        WindowGroup {
            #if !targetEnvironment(simulator)
            PoseRecognitionApp().edgesIgnoringSafeArea(.all)
                .background(Color(UIColor.orange))
            #else
            Text("QuickPose.ai requires a native arm64 device to run")
                .font(.system(size: 42, weight: .semibold)).foregroundColor(.red)
            #endif
        }
    }
}

struct PoseRecognitionApp: View {
    @State var cameraPermissionGranted = false
    var body: some View {
        GeometryReader { geometry in
            if cameraPermissionGranted {
                HomeView()
            }
        }.onAppear {
            AVCaptureDevice.requestAccess(for: .video) { accessGranted in
                DispatchQueue.main.async {
                    self.cameraPermissionGranted = accessGranted
                }
            }
        }
    }
}
