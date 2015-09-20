//
//  PaddleNode.swift
//  Breakout
//
//  Created by Harlan Haskins on 9/19/15.
//  Copyright © 2015 Harlan Haskins. All rights reserved.
//

import SpriteKit

class PaddleNode: SKSpriteNode {
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.yellowColor(), size: size)
        let physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody.affectedByGravity = false
        physicsBody.friction = 0.2
        physicsBody.restitution = 1.0
        physicsBody.linearDamping = 1.0
        physicsBody.categoryBitMask = CategoryMask.Paddle.rawValue
        physicsBody.allowsRotation = false
        physicsBody.dynamic = false
        self.physicsBody = physicsBody
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
