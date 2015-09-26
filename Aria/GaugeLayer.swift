//
//  GaugeLayer.swift
//  Aria
//
//  Created by Guy Harpak on 9/3/15.
//  Copyright (c) 2015 OnBudget. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit


class GaugeLayer : CAShapeLayer {
    var needle : CAShapeLayer

    override init () {
        needle = CAShapeLayer()
        super.init()
        //needle = nil
        self.bounds = CGRectMake (0,0,100,100)
        self.strokeColor = UIColor.blueColor().CGColor
        self.lineWidth = 3
        self.contents = UIImage(named: "blankGauge.png")?.CGImage
        self.contentsGravity = kCAGravityResize
        
        
        needle.path = UIBezierPath (rect: CGRectMake(0, 0, 2, -self.bounds.size.height/2+5)).CGPath
        needle.fillColor = UIColor.redColor().CGColor
        needle.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        self.addSublayer(needle)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateGauge (velocity: Double) {
        var angle = (velocity-1) * 2.5 
        angle = angle > 2.5 ? 2.5 : angle
        //let angle = velocity
        needle.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(angle)))
        
    }

    func rotateGauge (velocity: Double) {
        needle.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(velocity)))
        
    }


    
}