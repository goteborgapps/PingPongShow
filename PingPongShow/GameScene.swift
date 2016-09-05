//
//  GameScene.swift
//  PingPongShow
//
//  Created by Jason Kuan on 04/09/16.
//  Copyright (c) 2016 jsonkuan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    //How powerful is the hit
    let hitModifier : CGFloat = 20
    //Max/Max Vertical velocity
    let minVelocity : CGFloat = -800
    let maxVelocity : CGFloat = 800
    //initial speed
    let initialVector = CGVector(dx: 30, dy: 0)
    
    var leftPaddle : SKSpriteNode!
    var rightPaddle : SKSpriteNode!
    var theBall : SKSpriteNode!
    var oldLeftPosition : CGFloat = 0
    var oldRightPosition : CGFloat = 0
    var leftTranslation : CGFloat = 0
    var rightTranslation : CGFloat = 0
    
    
    override func didMoveToView(view: SKView) {
        //Set Up Border
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        self.physicsWorld.contactDelegate = self
        
        //Set up Paddles
        leftPaddle = self.childNodeWithName("LeftPaddle") as! SKSpriteNode
        oldLeftPosition = leftPaddle.position.y
        rightPaddle = self.childNodeWithName("RightPaddle") as! SKSpriteNode
        oldRightPosition = rightPaddle.position.y
        
        //Set up Ball
        theBall = self.childNodeWithName("Ball") as! SKSpriteNode
        theBall.physicsBody!.usesPreciseCollisionDetection = true;
        theBall.physicsBody!.applyImpulse(initialVector)
        //theBall.runAction(SKAction.applyForce(vector, atPoint: theBall.anchorPoint, duration: 0.1))
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            // Calculate the current, previous touch position and get a Y axis translation
            let positionInScene = touch.locationInNode(self)
            let previousPosition = touch.previousLocationInNode(self)
            let translation = CGFloat(positionInScene.y - previousPosition.y)
            
            // Adjust the Y pos of the nearest paddle to match the touch change
            if positionInScene.x < 200 {
                leftPaddle.position = CGPoint(x: leftPaddle.position.x, y: leftPaddle.position.y + translation)
            }else if positionInScene.x > 800 {
                rightPaddle.position = CGPoint(x: rightPaddle.position.x, y: rightPaddle.position.y + translation)
            }
        }
    }
    func didBeginContact(contact: SKPhysicsContact) {
        //On contact between sprites check which paddle is impacted and impart angular velocity relative to its movement speed
        var yVelocity : CGFloat = theBall.physicsBody!.velocity.dy
        if let firstNode = contact.bodyA.node as? SKSpriteNode, secondNode = contact.bodyB.node as? SKSpriteNode{
            if leftPaddle == firstNode || leftPaddle ==  secondNode{
                yVelocity += (leftTranslation*hitModifier)
            }else if rightPaddle == firstNode || rightPaddle == secondNode{
                yVelocity += (rightTranslation*hitModifier)
            }
            if yVelocity > maxVelocity {
                yVelocity = maxVelocity
            }else if yVelocity < minVelocity {
                yVelocity = minVelocity
            }
            theBall.physicsBody!.velocity.dy = yVelocity
        }
    }


    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //See how much paddles have moved so anglular momentum of ball can be calculated on contact
        let newLeftPos = leftPaddle.position.y
        let newRightPos = rightPaddle.position.y
        leftTranslation = ((newLeftPos - oldLeftPosition) * 0.9) + (leftTranslation * 0.1)
        rightTranslation = ((newRightPos - oldRightPosition) * 0.9) + (rightTranslation * 0.1)
        oldLeftPosition = newLeftPos
        oldRightPosition = newRightPos
        
    }
}

