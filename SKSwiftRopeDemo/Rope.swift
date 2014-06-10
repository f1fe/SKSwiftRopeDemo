//
//  Rope.swift
//  SKSwiftRopeDemo
//
//  Created by Jeremy Higgins on 6/10/14.
//  Copyright (c) 2014 Digital Buckeye. All rights reserved.
//

import SpriteKit

class Rope : SKNode {
    
    var ropeTexture : SKSpriteNode
    
    init(texture tex : SKSpriteNode, point1 p1 : CGPoint, point2 p2 : CGPoint) {
        self.ropeTexture = tex
        
        super.init()
        self.createRopes()
        
    }
    
    func createRopes() {
        self.ropeTexture.position = CGPoint(x: 100.0, y: 100.0)
        self.addChild(self.ropeTexture)
    }
    
}
