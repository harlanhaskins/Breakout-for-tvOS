//
//  BrickNode.swift
//  HelloWorld
//
//  Created by Harlan Haskins on 9/19/15.
//  Copyright © 2015 Harlan Haskins. All rights reserved.
//

import SpriteKit

class BrickNode: SKSpriteNode {
    let colors = ["044389", "fcff4b", "ffad05", "3abeff", "26ffe6"].map(UIColor.init)
    init(size: CGSize) {
        super.init(texture: nil, color: colors.randomItem, size: size)
        let physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = CategoryMask.Brick.rawValue
        physicsBody.dynamic = false
        self.physicsBody = physicsBody
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
