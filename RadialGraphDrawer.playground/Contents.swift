import UIKit
import PlaygroundSupport

let appBlue = UIColor(red: 30.0 / 255.0, green: 148.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
let appBlue30 = UIColor(red: 30.0 / 255.0, green: 148.0 / 255.0, blue: 250.0 / 255.0, alpha: 0.3)
let baseURL = playgroundSharedDataDirectory

let options = GraphOptions(baseOutputURL: baseURL, backgroundColor: .clear, circleColor: appBlue30, arcColor: appBlue, borderColor: .black, circleWidth: 2.0, borderWidthPercent:  0.015)
let generator = RadialGraphGenerator(size: CGSize(width: 44, height: 44), filePrefixName: "radialGraph", fileSufixName: "@2x", options: options)
generator.preview(percent: 0.33)
generator.preview(percent: 1.33)
generator.saveAll()
