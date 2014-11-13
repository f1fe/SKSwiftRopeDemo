//
//  GameScene.swift
//  SKSwiftRopeDemo
//
//  Created by Jeremy Higgins on 6/9/14.
//  Copyright (c) 2014 Digital Buckeye. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player : SKSpriteNode
    var anchor : SKSpriteNode
    
    required init?(coder aDecoder: NSCoder)  {
        player = SKSpriteNode()
        anchor = SKSpriteNode()
        
        super.init(coder: aDecoder)
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Physics border around screen
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)

        // Static Body
        self.anchor = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 50, height: 50))
        self.anchor.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - anchor.size.height)
        self.anchor.physicsBody = SKPhysicsBody(rectangleOfSize: anchor.frame.size)
        self.anchor.physicsBody?.dynamic = false
        self.anchor.physicsBody?.collisionBitMask = 1
        self.anchor.physicsBody?.categoryBitMask = 1
        self.anchor.physicsBody?.contactTestBitMask = 1
        self.addChild(self.anchor)
        
        // Dynamic Body
        self.player = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: 50, height: 50))
        self.player.position = CGPoint(x: player.size.width * 2, y: self.frame.size.height / 2)
        self.player.physicsBody = SKPhysicsBody(rectangleOfSize: player.frame.size)
        self.player.physicsBody?.collisionBitMask = 1
        self.player.physicsBody?.categoryBitMask = 1
        self.player.physicsBody?.contactTestBitMask = 1
        self.addChild(self.player)
        
        // Create Rope
        var rope = Rope(parentScene: self, node: self.player, node: self.anchor, texture: "rope.png")
        
        var label = SKLabelNode(text: "Tap on screen to move block")
        label.fontColor = UIColor.blackColor()
        label.position = CGPoint(x: self.frame.size.width / 2, y: 200)
        self.addChild(label)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            var location = touch.locationInNode(self)
            
            // Remove all rope nodes
            self.enumerateChildNodesWithName("rope", usingBlock: { node, stop in
                node.removeFromParent()
            })
            
            self.player.position = location
            self.player.zRotation = 0.0
            self.player.physicsBody?.velocity = CGVectorMake(0.0, 0.0);
            
            var rope = Rope(parentScene: self, node: self.player, node: self.anchor, texture: "rope.png")
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}
