import SwiftUI
import PencilKit
import Vision
import PlaygroundSupport
struct ContentView: View {
    @Environment(\.undoManager) var undoManager
    @State var color = UIColor.black
    @State var clear = false
    let canvas = PKCanvasView()
    var body: some View {
        VStack{
            PKCanvas(color: $color, clear:$clear)
           
            HStack(){
             
                Button("Undo") {
                                        self.undoManager?.undo()
                                    }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.gray)
                .cornerRadius(10)
                .frame(width: 80)
                                    Button("Redo") {
                                        self.undoManager?.redo()
                                    }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.gray)
                .cornerRadius(10)
                .frame(width: 80)
                Button("Clear"){ self.clear.toggle() }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.gray)
                .cornerRadius(10)
                .frame(width: 80)
    
                }
        }    }
    
}
struct PKCanvas: UIViewRepresentable {
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var pkCanvas: PKCanvas

        init(_ pkCanvas: PKCanvas) {
            self.pkCanvas = pkCanvas
        }
    }

    @Binding var color:UIColor
    @Binding var clear:Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.tool = PKInkingTool(.marker, color: color, width: 10)

        canvas.delegate = context.coordinator
        return canvas
    }

   func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        if clear != context.coordinator.pkCanvas.clear{
            canvasView.drawing = PKDrawing()
        }
        canvasView.tool = PKInkingTool(.marker, color: color, width: 10)
    
    }
   
}
    
PlaygroundPage.current.setLiveView(ContentView())

