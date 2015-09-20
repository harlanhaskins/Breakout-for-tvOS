//
//  DeathZoneNode.swift
//  HelloWorld
//
//  Created by Harlan Haskins on 9/19/15.
//  Copyright © 2015 Harlan Haskins. All rights reserved.
//

import SpriteKit

class DeathZoneNode: SKSpriteNode {
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.clearColor(), size: size)
        let physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = CategoryMask.DeathZone.rawValue
        physicsBody.dynamic = false
        self.physicsBody = physicsBody
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
