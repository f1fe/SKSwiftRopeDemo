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
    
    func createRope() {
        // Calculate distance & angle
        
        var deltaX = node2.position.x - node1.position.x
        var deltaY = node2.position.y - node1.position.y
        var total = deltaX * deltaX + deltaY * deltaY
        var distance = sqrtf(total)
        var points = Int(distance / SKSpriteNode(imageNamed: "rope.png").size.height);
        points -= 1;
        
        var vector = CGPoint(x: deltaX / Float(points), y: deltaY / Float(points))
        var previousNode : SKSpriteNode?
        var angle = atan2f(deltaY, deltaX)
        
        for i in 0...points {
            var x = self.node1.position.x
            var y = self.node1.position.y
            
            y += vector.y * Float(i)
            x += vector.x * Float(i)
            
            var ropePiece = SKSpriteNode(imageNamed: self.ropeTexture)
            ropePiece.name = "rope"
            ropePiece.position = CGPoint(x: x, y: y)
            ropePiece.zRotation = angle
            
            ropePiece.physicsBody = SKPhysicsBody(rectangleOfSize: ropePiece.size)
            ropePiece.physicsBody.collisionBitMask = 2
            ropePiece.physicsBody.categoryBitMask = 2
            ropePiece.physicsBody.contactTestBitMask = 2
            self.parentScene.addChild(ropePiece)
            
            if let pNode = previousNode {
                var pin = SKPhysicsJointPin.jointWithBodyA(pNode.physicsBody, bodyB: ropePiece.physicsBody, anchor: CGPoint(x: CGRectGetMidX(pNode.frame), y: CGRectGetMidY(pNode.frame)))
                self.parentScene.physicsWorld.addJoint(pin)
            } else {
                if i == 0 {
                    var pin = SKPhysicsJointPin.jointWithBodyA(self.node1.physicsBody, bodyB: ropePiece.physicsBody, anchor: CGPoint(x: CGRectGetMidX(self.node1.frame), y: CGRectGetMidY(self.node1.frame)))
                    self.parentScene.physicsWorld.addJoint(pin)
                }
            }
            
            previousNode = ropePiece
        }
        
        if let pNode = previousNode {
            var pin = SKPhysicsJointPin.jointWithBodyA(pNode.physicsBody, bodyB: self.node2.physicsBody, anchor: CGPoint(x: CGRectGetMidX(self.node2.frame), y: CGRectGetMidY(self.node2.frame)))
            self.parentScene.physicsWorld.addJoint(pin)
        }
    }
    
    func destroyRope() {
        self.parentScene.enumerateChildNodesWithName("rope", usingBlock: { node, stop in
            node.removeFromParent()
        })
    }
}
