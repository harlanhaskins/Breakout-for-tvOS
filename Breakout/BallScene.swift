//
//  BallScene.swift
//  Breakout
//
//  Created by Harlan Haskins on 9/18/15.
//  Copyright © 2015 Harlan Haskins. All rights reserved.
//

import SpriteKit

struct CategoryMask: OptionSetType {
    let rawValue: UInt32
    init(rawValue: UInt32) { self.rawValue = rawValue }
    static let allZeros = CategoryMask(rawValue: 0)
    static let Ball = CategoryMask(rawValue: 1 << 0)
    static let World = CategoryMask(rawValue: 1 << 1)
    static let Brick = CategoryMask(rawValue: 1 << 2)
    static let Paddle = CategoryMask(rawValue: 1 << 3)
    static let DeathZone = CategoryMask(rawValue: 1 << 4)
}

class BallScene: SKScene, SKPhysicsContactDelegate {
    let ball = BallNode(width: 24.0)
    let paddle = PaddleNode(size: CGSize(width: 200.0, height: 25.0))
    var activeBricks = [BrickNode]()
    var deathZone: DeathZoneNode!
    var ballIsActive = false
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = UIColor(white: 0.65, alpha: 1.0)
        let physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        physicsBody.collisionBitMask = ([.Ball, .Paddle] as CategoryMask).rawValue
        physicsBody.friction = 0.0
        self.physicsBody = physicsBody
        addChild(paddle)
        paddle.position = CGPoint(x: size.width / 2.0, y: 20.0 + paddle.size.height / 2.0)
        deathZone = DeathZoneNode(size: CGSize(width: size.width, height: 20.0))
        addChild(deathZone)
        deathZone.position = CGPoint(x: size.width / 2.0, y: deathZone.size.height / 2.0)
        physicsWorld.contactDelegate = self
        addBall()
        resetBricks()
    }
    
    func resetBricks() {
        activeBricks = createBricks()
        for brick in activeBricks {
            addChild(brick)
        }
    }
    
    func addBall() {
        ball.removeFromParent()
        addChild(ball)
        ball.position = CGPoint(x: paddle.calculateAccumulatedFrame().midX - ball.calculateAccumulatedFrame().width / 2.0, y: paddle.calculateAccumulatedFrame().maxY)
        let joint = SKPhysicsJointFixed.jointWithBodyA(ball.physicsBody!, bodyB: paddle.physicsBody!, anchor: ball.position)
        physicsWorld.addJoint(joint)
        ballIsActive = false
    }
    
    func createBricks() -> [BrickNode] {
        let numberPerLine = 7
        let lines = 5
        let spacing: CGFloat = 25.0
        let width: CGFloat = (size.width - (spacing * (CGFloat(numberPerLine) + 1))) / CGFloat(numberPerLine)
        let height: CGFloat = 45.0
        let startX = spacing + width / 2.0
        let startY = size.height - spacing - height / 2.0
        var bricks = [BrickNode]()
        for row in 0..<lines {
            for column in 0..<numberPerLine {
                let x = startX + (spacing + width) * CGFloat(column)
                let y = startY - (spacing + height) * CGFloat(row)
                let brick = BrickNode(size: CGSize(width: width, height: height))
                brick.position = CGPoint(x: x, y: y)
                bricks.append(brick)
            }
        }
        return bricks
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, nodeB = contact.bodyB.node else { return }
        guard let ball = (nodeA as? BallNode ?? nodeB as? BallNode) else { return }
        if let paddle = (nodeA as? PaddleNode ?? nodeB as? PaddleNode) {
            let point = convertPoint(ball.position, toNode: paddle)
            let dX = point.x / (paddle.size.width / 2.0)
            ball.physicsBody?.applyImpulse(CGVector(dx: dX, dy: 0))
        }
        if let _ = (nodeA as? DeathZoneNode ?? nodeB as? DeathZoneNode) {
            addBall()
        }
        if let brick = (nodeA as? BrickNode ?? nodeB as? BrickNode) {
            let action = SKAction.fadeOutWithDuration(0.1)
            let remove = SKAction.removeFromParent()
            brick.runAction(SKAction.sequence([action, remove]))
            if let index = activeBricks.indexOf(brick) {
                activeBricks.removeAtIndex(index)
            }
            if activeBricks.isEmpty {
                addBall()
                resetBricks()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didPress(recognizer: UIGestureRecognizer) {
        guard !ballIsActive else { return }
        physicsWorld.removeAllJoints()
        let vector = CGVector(dx: CGFloat(random(-5, end: 5)), dy: CGFloat(random(-30, end: -20)))
        ball.physicsBody?.applyImpulse(vector)
        ballIsActive = true
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.locationInNode(self)
        let previousTouchLocation = touch.previousLocationInNode(self)
        var paddleX = paddle.position.x + (touchLocation.x - previousTouchLocation.x)
        paddleX = max(paddleX, paddle.size.width / 2.0)
        paddleX = min(paddleX, size.width - (paddle.size.width / 2.0))
        paddle.position = CGPoint(x: paddleX, y: paddle.position.y)
    }

}