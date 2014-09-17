//
//  Rope.swift
//  SKSwiftRopeDemo
//
//  Created by Jeremy Higgins on 6/10/14.
//  Copyright (c) 2014 Digital Buckeye. All rights reserved.
//

import SpriteKit

class Rope : SKNode {
    
    var ropeTexture : String
    var node1 : SKNode
    var node2 : SKNode
    var parentScene : SKScene
    
    init(parentScene scene : SKScene, node node1 : SKNode, node node2 : SKNode, texture tex : String) {
        
        self.ropeTexture = tex
        self.node1 = node1
        self.node2 = node2
        self.parentScene = scene
        
        super.init()
        self.name = "rope"
        
        self.createRope()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createRope() {
        // Calculate distance & angle
        
        var deltaX = node2.position.x - node1.position.x
        var deltaY = node2.position.y - (node1.position.y  + (node1.frame.size.height / 2))
        var total = deltaX * deltaX + deltaY * deltaY
        var distance = Float(sqrtf(Float(total)))
        var height = Float(SKSpriteNode(imageNamed: "rope.png").size.height - 1.0)
        var p = (distance / height)
        
        var points = Int(p)
        points -= 1;
        
        let vX = CGFloat(deltaX) / CGFloat(points)
        let vY = CGFloat(deltaY) / CGFloat(points)
        
        var vector = CGPoint(x: vX, y: vY)
        var previousNode : SKSpriteNode?
        var angle = atan2f(Float(deltaY), Float(deltaX))
        
        for i in 0...points {
            var x = self.node1.position.x
            var y = self.node1.position.y + (self.node1.frame.size.height / 2)
            
            y += vector.y * CGFloat(i)
            x += vector.x * CGFloat(i)
            
            var ropePiece = SKSpriteNode(imageNamed: self.ropeTexture)
            ropePiece.name = "rope"
            ropePiece.position = CGPoint(x: x, y: y)
            ropePiece.zRotation = CGFloat(angle + 1.57)
            ropePiece.zPosition = -1
            
            ropePiece.physicsBody = SKPhysicsBody(rectangleOfSize: ropePiece.size)
            
            ropePiece.physicsBody?.collisionBitMask = 2
            ropePiece.physicsBody?.categoryBitMask = 2
            ropePiece.physicsBody?.contactTestBitMask = 2
            
            self.parentScene.addChild(ropePiece)
            
            if let pNode = previousNode {
                var pin = SKPhysicsJointPin.jointWithBodyA(pNode.physicsBody, bodyB: ropePiece.physicsBody, anchor: CGPoint(x: CGRectGetMidX(ropePiece.frame), y: CGRectGetMidY(ropePiece.frame)))
                self.parentScene.physicsWorld.addJoint(pin)
            } else {
                if i == 0 {
                    var pin = SKPhysicsJointPin.jointWithBodyA(self.node1.physicsBody, bodyB: ropePiece.physicsBody, anchor: CGPoint(x: CGRectGetMidX(self.node1.frame), y: CGRectGetMaxY(self.node1.frame)))
                    self.parentScene.physicsWorld.addJoint(pin)
                }
            }
            
            previousNode = ropePiece
        }
        
        if let pNode = previousNode {
            var pin = SKPhysicsJointPin.jointWithBodyA(self.node2.physicsBody, bodyB: pNode.physicsBody, anchor: CGPoint(x: CGRectGetMidX(pNode.frame), y: CGRectGetMidY(pNode.frame)))
            self.parentScene.physicsWorld.addJoint(pin)
        }
    }
    
    func destroyRope() {
        self.parentScene.enumerateChildNodesWithName("rope", usingBlock: { node, stop in
            node.removeFromParent()
        })
    }
}
