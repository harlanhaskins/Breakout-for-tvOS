//
//  ViewController.swift
//  HelloWorld
//
//  Created by Harlan Haskins on 9/18/15.
//  Copyright © 2015 Harlan Haskins. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var skView: SKView!
    var scene: BallScene!
    var previousPoint = CGPoint.zero
    
    override func viewDidLoad() {
        scene = BallScene(size: skView.frame.size)
        skView.presentScene(scene)
        let pressRecognizer = UITapGestureRecognizer(target: scene, action: "didPress:")
        pressRecognizer.delegate = self
        pressRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        view.addGestureRecognizer(pressRecognizer)
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceivePress press: UIPress) -> Bool {
        return true
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension CGFloat {
    var signum: CGFloat {
        return self < 0 ? -1 : 1
    }
}