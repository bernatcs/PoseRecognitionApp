//
//  PoseRecognitionAppApp.swift
//  PoseRecognitionApp
//
//  Created by Bernat CS - SBP on 18/7/24.
//

import SwiftUI
import AVFoundation

@main
struct QuickPose_DemoApp: App {
    var body: some Scene {
        WindowGroup {
            #if !targetEnvironment(simulator)
            DemoAppView().edgesIgnoringSafeArea(.all)
                .background(Color("AccentColor"))
            #else
            Text("QuickPose.ai requires a native arm64 device to run")
                .font(.system(size: 42, weight: .semibold)).foregroundColor(.red)
            #endif
        }
    }
}

struct DemoAppView: View {
    @State var cameraPermissionGranted = false
    var body: some View {
        GeometryReader { geometry in
            if cameraPermissionGranted {
                ContentView()
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
