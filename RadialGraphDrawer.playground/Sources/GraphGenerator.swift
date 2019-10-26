import UIKit
import PlaygroundSupport

extension UIView {
    func asImage(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { ctx in
            drawHierarchy(in: CGRect(origin: .zero, size: size), afterScreenUpdates: true)
        }
        return image
    }
}

class RadialGraphView: UIView {
    private let percent: Float
    private let options: GraphOptions

    init(frame: CGRect, percent: Float, options: GraphOptions) {
        self.percent = percent
        self.options = options
        super.init(frame: frame)

        backgroundColor = options.backgroundColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineWidth(options.circleWidth)
        context.setLineCap(.round)

        let circleFill: CGFloat = CGFloat(percent)
        let startPoint = -(CGFloat.pi / 2)
        let endPoint = 2 * CGFloat.pi * circleFill + startPoint

        context.setStrokeColor(options.circleColor.cgColor)
        drawArc(in: context, startPoint: startPoint, endPoint: 2 * CGFloat.pi + startPoint)

        context.setStrokeColor(options.arcColor.cgColor)
        drawArc(in: context, startPoint: startPoint, endPoint: endPoint)
    }

    private func drawArc(in context: CGContext, startPoint: CGFloat, endPoint: CGFloat) {
        context.addArc(center: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                        radius: frame.size.width / 2.0 - options.circleWidth / 2.0,
                        startAngle: startPoint,
                        endAngle: endPoint,
                        clockwise: false)
        context.strokePath()
    }
}

public class RadialGraphGenerator {
    private let size: CGSize
    private let filePrefixName: String
    private let fileSufixName: String
    private let options: GraphOptions

    public init(size: CGSize, filePrefixName: String, fileSufixName: String, options: GraphOptions) {
        self.size = CGSize(width: size.width / 2, height: size.height / 2)
        self.filePrefixName = filePrefixName
        self.fileSufixName = fileSufixName
        self.options = options
    }

    public func preview(percent: Float) -> UIImage {
        return graph(for: percent)
    }

    public func saveAll() {
        print("Save to: \(playgroundSharedDataDirectory)")
        for i in 0..<101 {
            let graphImage = graph(for: Float(i) / Float(100))
            let data = graphImage.pngData()
            let path = playgroundSharedDataDirectory.appendingPathComponent("\(filePrefixName)\(i)\(fileSufixName).png")
            try! data?.write(to: path)
        }
    }

    func graph(for percent: Float) -> UIImage {
        let graph = RadialGraphView(frame: CGRect(origin: .zero, size: size), percent: percent, options: options)
        let image = graph.asImage(size: size)
        return image
    }
}


public struct GraphOptions {
    let backgroundColor: UIColor
    let circleColor: UIColor
    let circleWidth: CGFloat
    let arcColor: UIColor

    public init(backgroundColor: UIColor, circleColor: UIColor, circleWidth: CGFloat, arcColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.circleColor = circleColor
        self.circleWidth = circleWidth
        self.arcColor = arcColor
    }
}
