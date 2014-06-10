//
//  GameScene.swift
//  SKSwiftRopeDemo
//
//  Created by Jeremy Higgins on 6/9/14.
//  Copyright (c) 2014 Digital Buckeye. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Physics border around screen
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        // Static Body
        var anchor = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 50, height: 50))
        anchor.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - anchor.size.height)
        anchor.physicsBody = SKPhysicsBody(rectangleOfSize: anchor.frame.size)
        anchor.physicsBody.dynamic = false
        self.addChild(anchor)
        
        // Dynamic Body
        var player = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: player.size.width * 2, y: self.frame.size.height / 2)
        //player.position.x += 400
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.frame.size)
        self.addChild(player)
        
        // Create Rope
        var rope = Rope(parentScene: self, node: player, node: anchor, texture: "rope.png")
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            var location = touch.locationInNode(self)
            var rope = self.childNodeWithName("rope")
            rope.position = location
            println(rope.position)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
