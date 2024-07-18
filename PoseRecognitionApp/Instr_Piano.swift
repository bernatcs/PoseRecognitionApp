import SwiftUI
import QuickPoseCore
import QuickPoseSwiftUI

struct Instr_Piano: View {
    private var quickPose = QuickPose(sdkKey: sdkKey.sdkKey)
    @State private var overlayImage: UIImage?
    @State private var useFrontCamera: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                // Vista de cámara QuickPose
                QuickPoseCameraSwitchView(useFrontCamera: $useFrontCamera, delegate: quickPose)
                    .edgesIgnoringSafeArea(.all)
                
                // Vista de superposición QuickPose
                QuickPoseOverlayView(overlayImage: $overlayImage)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            useFrontCamera.toggle()
                        }) {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .font(.system(size: 50))
                                .padding()
                        }
                    }
                }
                .navigationBarHidden(true)
                .onAppear {
                    let basicStyle = QuickPose.Style(relativeFontSize: 0.5, relativeArcSize: 0.2, relativeLineWidth: 0.5, conditionalColors: [QuickPose.Style.ConditionalColor(min: nil, max: 99, color: UIColor.green)])
                    quickPose.start(features: [.rangeOfMotion(.hip(side: .right, clockwiseDirection: false), style: basicStyle)]) { status, outputImage, _, _, _ in
                        if case .success = status {
                            overlayImage = outputImage
                        } else {
                            // Manejar el error si es necesario
                            print("Error al procesar la imagen de superposición")
                        }
                    }
                }
                .onDisappear {
                    quickPose.stop()
                }
            }
            .navigationBarTitle("") // Esto evita que el título predeterminado ocupe espacio en la barra de navegación
            .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso automático
            
            // Botón personalizado para retroceder
            .navigationBarItems(leading: Button(action: {
                // Aquí puedes agregar cualquier lógica adicional antes de retroceder, si es necesario
                // Por ejemplo, detener cualquier proceso en curso
            }) {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.blue)
            })
        }
    }
}

struct Instr_Piano_Previews: PreviewProvider {
    static var previews: some View {
        Instr_Piano()
    }
}

//            VStack {
//                Spacer()
//                Button(action: {
//                    useFrontCamera = !useFrontCamera
//                }) {
//                    Image(systemName: "arrow.triangle.2.circlepath.camera")
//                        .font(.system(size: 50))
//                        .padding()
////                            .background(Color.white.opacity(0.7))
////                            .clipShape(Circle())
//                }
////                    .padding(.bottom, 10) // Ajusta el espaciado desde el fondo
//            }

//var body: some View {
//    GeometryReader { geometry in
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Button("Start") {
//                showOverlay = true
//            }
//        }
//        .padding()
//        .frame(width: geometry.size.width, height: geometry.size.height)
//        .fullScreenCover(isPresented: $showOverlay) {
//            ZStack{
//                
//                if ProcessInfo.processInfo.isiOSAppOnMac {
//                    QuickPoseSimulatedCameraView(useFrontCamera: false, delegate: quickPose, video: Bundle.main.url(forResource: "pp", withExtension: "mp4")!)
//                } else {
//                    QuickPoseCameraSwitchView(useFrontCamera: $useFrontCamera, delegate: quickPose)
////                        QuickPoseCameraView(useFrontCamera: !true, delegate: quickPose)
//                }
//                QuickPoseOverlayView(overlayImage: $overlayImage)
//            }
//            .frame(width: geometry.size.width, height: geometry.size.height)
//            .onAppear {
//                let basicStyle = QuickPose.Style(relativeFontSize: 0.5, relativeArcSize: 0.2, relativeLineWidth: 0.5, conditionalColors: [QuickPose.Style.ConditionalColor(min: nil, max: 99, color: UIColor.green)])
//                quickPose.start(features: [.rangeOfMotion(.hip(side: .right, clockwiseDirection: false), style: basicStyle)]) { _, outputImage, _, _, _ in
//                    overlayImage = outputImage
//                }
//            }.onDisappear{
//                quickPose.stop()
//            }.overlay(alignment: .topTrailing){
//                Button("Done") {
//                    showOverlay = false
//                }.foregroundColor(Color.white).font(.system(size: 30)).padding(.trailing, 16)
//            }.overlay(alignment: .topLeading){
//                Button("Swap") {
//                    useFrontCamera = !useFrontCamera
//                }.foregroundColor(Color.white).font(.system(size: 30)).padding(.leading, 16)
//            }
//        }
//    }
//}
