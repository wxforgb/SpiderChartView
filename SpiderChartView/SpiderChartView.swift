//
//  SpiderChartView.swift
//  SpiderChartView
//
//  Created by Wang Xin on 2018/08/27.
//  Copyright © 2018年 wx. All rights reserved.
//

import Foundation
import Macaw

class SpiderChartView: MacawView {
    
    // MARK: - Options
    // Option: the radius of circle
    private let r: Double = 62.0
    // Option: the distance from the label to the circle
    private let textDistance: Double = 20.0
    // Option: the color of circel border
    private let circleBorderColor = Color(val: 0x737373)
    // Option: the color of circel border
    private let circleBorderWidth: Double = 1
    // Option: the color of label
    private let textLabelColor = Color(val: 0x333333)
    // Option: the inner line color of axis
    private let innerAxisLineColor = Color(val: 0xD9D9D9)
    // Option: the color of value area
    private let valueAreaColor = Color(val: 0x24b4c0)
    // Option: the text font of label
    private let textFont = Font()
    
    
    // MARK: - main method
    func create(ratingAxisValues: [(String, Double)]) {
        guard !ratingAxisValues.isEmpty else { return }
        
        let centerX: Double = 0
        let centerY: Double = 0
        let textDistanceRate: Double = (r + textDistance) / r
        let ratingAxisCount = ratingAxisValues.count
        
        var items: [Node] = []
        
        // create the border of circle
        let shape = Shape(
            form: Circle(cx: centerX, cy: centerY, r: r),
            fill: Color.white,
            stroke: Stroke(fill: circleBorderColor, width: circleBorderWidth))
        items.append(shape)
        
        var ratingAxisLines: [Node] = []
        var innerAreaPoints: [Double] = []
        
        let unitRadians = 2 * .pi / Double(ratingAxisCount)
        for i in 0...(ratingAxisCount - 1) {
            let x2 = sin(unitRadians * Double(i)) * r
            let y2 = cos(unitRadians * Double(i)) * r * -1
            
            // 1. create the line of axis
            ratingAxisLines.append(
                Line(x1: centerX,
                     y1: centerY,
                     x2: x2,
                     y2: y2).stroke(fill: innerAxisLineColor)
            )
            
            // 2. create the label
            let text = ratingAxisValues[i].0
            let align = calcuateAlign(x2)
            // If the length of the label's text is over 4, Divide into two lines
            if text.count > 4 {
                ratingAxisLines.append(
                    Text(text: String(text.prefix(4)),
                         font: textFont,
                         fill: textLabelColor,
                         align: align,
                         baseline: .mid,
                         place: .move(dx: textDistanceRate * x2, dy: textDistanceRate * y2)))
                ratingAxisLines.append(
                    Text(text: String(text.suffix(text.count - 4)),
                         font: textFont,
                         fill: textLabelColor,
                         align: align,
                         baseline: .mid,
                         place: .move(dx: textDistanceRate * x2, dy: textDistanceRate * y2 + 14)))
            } else {
                ratingAxisLines.append(
                    Text(text: text,
                         font: textFont,
                         fill: textLabelColor,
                         align: align,
                         baseline: .mid,
                         place: .move(dx: textDistanceRate * x2, dy: textDistanceRate * y2)))
            }
            
            // 3. save the points of value
            innerAreaPoints.append(x2 * ratingAxisValues[i].1)
            innerAreaPoints.append(y2 * ratingAxisValues[i].1)
        }
        
        // 4. create value area
        let valueArea = Shape(
            form: Polygon(points: innerAreaPoints),
            fill: valueAreaColor,
            stroke: nil)
        items.append(valueArea)
        items.append(contentsOf: ratingAxisLines)
        
        self.node = Group(contents: items, place: .move(dx: Double(self.frame.size.width / 2), dy: Double(self.frame.size.height / 2)))
    }
    
    // MARK: - private method
    private func calcuateAlign(_ x: Double) -> Align {
        if x >= -0.1 && x <= 0.1 {
            return .mid
        } else if x > 0 {
            return .min
        } else {
            return .max
        }
    }
}

