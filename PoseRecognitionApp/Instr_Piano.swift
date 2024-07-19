import SwiftUI
import QuickPoseCore
import QuickPoseSwiftUI

struct Instr_Piano: View {
    private var quickPose = QuickPose(sdkKey: sdkKey.sdkKey)
    @State private var overlayImage: UIImage?
    @State private var useFrontCamera: Bool = true
    
    

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack (alignment: .top) {
                    if ProcessInfo.processInfo.isiOSAppOnMac, let url = Bundle.main.url(forResource: "Piano Posture", withExtension: "mp4") {
                        QuickPoseSimulatedCameraView(useFrontCamera: false, delegate: quickPose, video: url)
                    } else {
                        QuickPoseCameraSwitchView(useFrontCamera: $useFrontCamera, delegate: quickPose)
                    }
                    QuickPoseOverlayView(overlayImage: $overlayImage)
                }
//                .frame(width: geometry.size.width)
                .frame(width: geometry.safeAreaInsets.leading + geometry.size.width + geometry.safeAreaInsets.trailing)
//                .aspectRatio(contentMode: .fill)
//                .clipped()
                .edgesIgnoringSafeArea(.all)
                .overlay(alignment: .bottom){
                    Button(action: {
                        useFrontCamera.toggle()
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .font(.system(size: 30))
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    .padding(.bottom, 20)
                }
                .onAppear {
                    
//                    let modelConfigLite = QuickPose.ModelConfig(detailedFaceTracking: false, detailedHandTracking: false, modelComplexity: .light)
//                    let modelConfigGood = QuickPose.ModelConfig(detailedFaceTracking: true, detailedHandTracking: true, modelComplexity: .good)
                    let modelConfigHeavy = QuickPose.ModelConfig(detailedFaceTracking: true, detailedHandTracking: true, modelComplexity: .heavy)
                    
                    let basicStyleHip = QuickPose.Style(
                        relativeFontSize: 0.5,
                        relativeArcSize: 0.2,
                        relativeLineWidth: 0.5,
                        conditionalColors: [QuickPose.Style.ConditionalColor(min: 95, max: 115, color: UIColor.green)]
                    )
                    
                    quickPose.start(features: [.rangeOfMotion(.hip(side: .right, clockwiseDirection: false), style: basicStyleHip)], modelConfig: modelConfigHeavy) { status, outputImage, _, _, _ in
                        overlayImage = outputImage
                    
//                    quickPose.start(features: [.overlay(.upperBody)], modelConfig: modelConfigHeavy) { status, outputImage, _, _, _ in
//                        overlayImage = outputImage
                        
//                    quickPose.start(features: [.], modelConfig: modelConfigHeavy) { status, outputImage, _, _, _ in
//                        overlayImage = outputImage
                    }
                }
                .onDisappear {
                    quickPose.stop()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// meh
