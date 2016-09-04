//
//  GameScene.swift
//  PingPongShow
//
//  Created by Jason Kuan on 04/09/16.
//  Copyright (c) 2016 jsonkuan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
//    let invert = CGFloat(-1)
//    var grav = CGFloat(5.5)
    var leftPaddle : SKSpriteNode? = nil
    var rightPaddle : SKSpriteNode? = nil
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let vector = CGVector(dx: 160, dy: 0)
        if let theBall = self.childNodeWithName("Ball") as? SKSpriteNode{
            theBall.runAction(SKAction.applyForce(vector, atPoint: theBall.anchorPoint, duration: 0.1))
        }
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//       /* Called when a touch begins */
//        
//
//
//        
//    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            var paddle : SKSpriteNode? = nil
            let location = touch.locationInNode(self)
            if location.x < 200 {
                if let aLeftPaddle = self.childNodeWithName("LeftPaddle") as? SKSpriteNode{
                    paddle = aLeftPaddle

                }
            }else if location.x > 800 {
                if let aRightPaddle = self.childNodeWithName("RightPaddle") as? SKSpriteNode{
                    paddle = aRightPaddle
                }
            }
            if (paddle != nil) {
                let positionInScene = touch.locationInNode(self)
                let previousPosition = touch.previousLocationInNode(self)
                let translation = CGFloat(positionInScene.y - previousPosition.y)
                paddle!.position = CGPoint(x: paddle!.position.x, y: paddle!.position.y + translation)
            }
        }
//        for touch in touches {
////            let location = touch.locationInNode(self)
////            if let paddle = self.nodeAtPoint(location) as? SKSpriteNode {
//                let positionInScene = touch.locationInNode(self)
//                let previousPosition = touch.previousLocationInNode(self)
//                let translation = CGFloat(positionInScene.y - previousPosition.y)
//                paddle.position = CGPoint(x: paddle.position.x, y: paddle.position.y + translation)
//                //paddle = nil
//            }
//        }
    }


    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}



//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!"
//        myLabel.fontSize = 45
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
//
//        self.addChild(myLabel)





//        for touch in touches {
//            let location = touch.locationInNode(self)
//
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//
//            sprite.xScale = 0.1
//            sprite.yScale = 0.1
//            sprite.position = location
//
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//
//            sprite.runAction(SKAction.repeatActionForever(action))
//
//            self.addChild(sprite)
//        }
