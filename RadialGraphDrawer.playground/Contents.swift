import UIKit
import SwiftUI

let appBlue = UIColor(red: 30.0 / 255.0, green: 148.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
let appBlue30 = UIColor(red: 30.0 / 255.0, green: 148.0 / 255.0, blue: 250.0 / 255.0, alpha: 0.3)

let options = GraphOptions(backgroundColor: .clear, circleColor: appBlue30, circleWidth: 3.0, arcColor: appBlue)
let generator = RadialGraphGenerator(size: CGSize(width: 44, height: 44), filePrefixName: "radialGraph", fileSufixName: "@2x", options: options)
generator.preview(percent: 0.33)
generator.saveAll()
