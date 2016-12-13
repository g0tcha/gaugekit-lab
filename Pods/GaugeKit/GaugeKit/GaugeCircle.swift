//
//  Gauge.swift
//  SWGauge
//
//  Created by Petr Korolev on 02/06/15.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

import UIKit
import QuartzCore


protocol GaugeCircle {
    func getCircleGauge(rotateAngle: Double) -> CAShapeLayer
}

extension Gauge: GaugeCircle {    
    func getCircleGauge(rotateAngle: Double) -> CAShapeLayer {
        
        let gaugeLayer = CAShapeLayer()
        
        //        let rotatedBounds = CGRectMake(10, 10, bounds.height, bounds.width)
        let newBounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.height, bounds.width * 2 - lineWidth)
        //        var newBounds = bounds
        if bgLayer == nil {
            var bgLayerBounds = layer.bounds
            bgLayerBounds.origin.x += 2
            bgLayerBounds.origin.y += 2
            bgLayerBounds.size.width -= 10
            bgLayerBounds.size.height -= 10
            
            bgLayer = CAShapeLayer.getOval(0.4, strokeStart: 0, strokeEnd: 1, strokeColor: _bgStartColor, fillColor: UIColor.clearColor(), shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSize.zero, bounds: bgLayerBounds)
            bgLayer.frame = bgLayerBounds
            gaugeLayer.addSublayer(bgLayer)
        }
        
        if bgGradientLayer == nil {
            bgGradientLayer = CAGradientLayer()
            if isCircle && (layer.bounds.width < layer.bounds.height) {
                let adjust: CGFloat = (layer.bounds.height - layer.bounds.width) / 2 / layer.bounds.height
                bgGradientLayer.startPoint = CGPointMake(0.5, 1 - adjust)
                bgGradientLayer.endPoint = CGPointMake(0.5, adjust)
            } else {
                bgGradientLayer.startPoint = CGPointMake(0.5, 1)
                bgGradientLayer.endPoint = CGPointMake(0.5, 0)
            }
            bgGradientLayer.colors = [_bgStartColor.CGColor, _bgEndColor.CGColor]
            bgGradientLayer.frame = layer.bounds
            bgGradientLayer.mask = bgLayer
            gaugeLayer.addSublayer(bgGradientLayer)
        }
        
        if ringLayer == nil {
            ringLayer = CAShapeLayer.getOval(lineWidth, strokeStart: 0, strokeEnd: 1, strokeColor: UIColor.clearColor(), fillColor: UIColor.clearColor(), shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSize.zero, bounds: bounds)
            
            ringLayer.frame = layer.bounds
            
            gaugeLayer.addSublayer(ringLayer)
        }
        
        if ringGradientLayer == nil {
            ringGradientLayer = CAGradientLayer()
            if isCircle && (layer.bounds.width < layer.bounds.height) {
                let adjust: CGFloat = (layer.bounds.height - layer.bounds.width) / 2 / layer.bounds.height
                ringGradientLayer.startPoint = CGPointMake(0.5, 1 - adjust)
                ringGradientLayer.endPoint = CGPointMake(0.5, adjust)
            } else {
                ringGradientLayer.startPoint = CGPointMake(0.5, 1)
                ringGradientLayer.endPoint = CGPointMake(0.5, 0)
            }
            
            let endColor = UIColor(red: 246/255, green: 169/255, blue: 89/255, alpha: 1).CGColor
            let startColor = UIColor(red: 233/255, green: 102/255, blue: 62/255, alpha: 1).CGColor
            
            ringGradientLayer.colors = [startColor, endColor]
            ringGradientLayer.frame = layer.bounds
            ringGradientLayer.mask = ringLayer
            gaugeLayer.addSublayer(ringGradientLayer)
        }
        
        if roundCap {
            ringLayer.lineCap = kCALineCapRound
            bgLayer.lineCap = kCALineCapRound
        }
        
        gaugeLayer.frame = layer.bounds
        gaugeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gaugeLayer.transform = CATransform3DRotate(gaugeLayer.transform, CGFloat(rotateAngle), 0, 0, 1)
        if reverse {
            reverseY(gaugeLayer)
        }
        
        if type == .Right {
            reverseX(gaugeLayer)
        }
        
        return gaugeLayer
    }
}
