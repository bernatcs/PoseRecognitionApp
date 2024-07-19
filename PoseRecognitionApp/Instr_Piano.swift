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
                ZStack {
                    if ProcessInfo.processInfo.isiOSAppOnMac, let url = Bundle.main.url(forResource: "Instr_Piano_demo", withExtension: "mp4") {
                        QuickPoseSimulatedCameraView(useFrontCamera: false, delegate: quickPose, video: url)
                    } else {
                        QuickPoseCameraSwitchView(useFrontCamera: $useFrontCamera, delegate: quickPose)
                    }
                    QuickPoseOverlayView(overlayImage: $overlayImage)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .aspectRatio(contentMode: .fill)
                .clipped()
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
                    let basicStyle = QuickPose.Style(
                        relativeFontSize: 0.5,
                        relativeArcSize: 0.2,
                        relativeLineWidth: 0.5,
                        conditionalColors: [QuickPose.Style.ConditionalColor(min: 85, max: 100, color: UIColor.green)]
                    )
                    
                    quickPose.start(features: [.rangeOfMotion(.hip(side: .right, clockwiseDirection: false), style: basicStyle)]) { status, outputImage, _, _, _ in
                        overlayImage = outputImage
                    }
                }
                .onDisappear {
                    quickPose.stop()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    Instr_Piano()
}



//import SwiftUI
//import QuickPoseCore
//import QuickPoseSwiftUI
//
//struct Instr_Piano: View {
//    private var quickPose = QuickPose(sdkKey: sdkKey.sdkKey)
//    @State private var overlayImage: UIImage?
//    @State private var useFrontCamera: Bool = true
//
//    var body: some View {
//        NavigationView {
//            GeometryReader { geometry in
//                ZStack {
//                    if ProcessInfo.processInfo.isiOSAppOnMac, let url = Bundle.main.url(forResource: "Instr_Piano_demo", withExtension: "mp4") {
//                        QuickPoseSimulatedCameraView(useFrontCamera: false, delegate: quickPose, video: url)
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: geometry.size.width, height: geometry.size.height)
//                            .clipped()
//                            .background(Color.black)
//                    } else {
//                        QuickPoseCameraSwitchView(useFrontCamera: $useFrontCamera, delegate: quickPose)
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: geometry.size.width, height: geometry.size.height)
//                            .clipped()
//                            .background(Color.black)
//                    }
//                    
//                    QuickPoseOverlayView(overlayImage: $overlayImage)
//                    
//                    VStack {
//                        Spacer()
//                        HStack {
//                            if geometry.size.width > geometry.size.height {
//                                Spacer() // Empuja el botón a la derecha en landscape
//                                Button(action: {
//                                    useFrontCamera.toggle()
//                                }) {
//                                    Image(systemName: "arrow.triangle.2.circlepath.camera")
//                                        .font(.system(size: 30))
//                                        .padding()
//                                        .background(Color.white.opacity(0.8))
//                                        .clipShape(Circle())
//                                }
//                                .padding(.bottom, 20)
//                                .padding(.trailing, 20)
//                            } else {
//                                Spacer() // Centra el botón horizontalmente en portrait
//                                Button(action: {
//                                    useFrontCamera.toggle()
//                                }) {
//                                    Image(systemName: "arrow.triangle.2.circlepath.camera")
//                                        .font(.system(size: 30))
//                                        .padding()
//                                        .background(Color.white.opacity(0.8))
//                                        .clipShape(Circle())
//                                }
//                                .padding(.bottom, 20)
//                                Spacer() // Mantiene el botón centrado
//                            }
//                        }
//                        .frame(width: geometry.size.width) // Asegura que HStack ocupe todo el ancho
//                    }
//                }
//                .navigationBarHidden(true)
//                .onAppear {
//                    let basicStyle = QuickPose.Style(
//                        relativeFontSize: 0.5,
//                        relativeArcSize: 0.2,
//                        relativeLineWidth: 0.5,
//                        conditionalColors: [QuickPose.Style.ConditionalColor(min: nil, max: 99, color: UIColor.green)]
//                    )
//                    
//                    quickPose.start(features: [.rangeOfMotion(.hip(side: .right, clockwiseDirection: false), style: basicStyle)]) { status, outputImage, _, _, _ in
//                        if case .success = status {
//                            overlayImage = outputImage
//                        } else {
//                            print("Error processing overlay image")
//                        }
//                    }
//                }
//                .onDisappear {
//                    quickPose.stop()
//                }
//            }
//            .edgesIgnoringSafeArea(.all)
//            .aspectRatio(contentMode: .fill)
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//    }
//}
//
//#Preview {
//    Instr_Piano()
//}
