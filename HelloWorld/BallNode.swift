//
//  BallNode.swift
//  HelloWorld
//
//  Created by Harlan Haskins on 9/19/15.
//  Copyright © 2015 Harlan Haskins. All rights reserved.
//

import SpriteKit

class BallNode: SKShapeNode {
    init(width: CGFloat) {
        super.init()
        path = CGPathCreateWithEllipseInRect(CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: width)), nil)
        fillColor = UIColor.redColor()
        strokeColor = UIColor.clearColor()
        let physicsBody = SKPhysicsBody(circleOfRadius: 12.0, center: CGPoint(x: width / 2.0, y: width / 2.0))
        physicsBody.affectedByGravity = false
        physicsBody.friction = 0.0
        physicsBody.restitution = 1.0
        physicsBody.linearDamping = 0.0
        physicsBody.categoryBitMask = CategoryMask.Ball.rawValue
        physicsBody.collisionBitMask = ([.World, .Paddle, .Brick, .DeathZone] as CategoryMask).rawValue
        physicsBody.contactTestBitMask = ([.DeathZone, .Brick] as CategoryMask).rawValue
        self.physicsBody = physicsBody
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
