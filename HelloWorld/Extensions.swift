//
//  Extensions.swift
//  HelloWorld
//
//  Created by Harlan Haskins on 9/19/15.
//  Copyright © 2015 Harlan Haskins. All rights reserved.
//

import UIKit

func random(start: Int = 0, end: Int) -> Int {
    return Int(arc4random_uniform(UInt32(end - start))) + start
}

extension Array {
    var randomItem: Element {
        return self[random(end: self.count)]
    }
}

extension UIColor {
    var hex: String {
        let convert: CGFloat -> Int = { return lround(Double($0 * 255.0)) }
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "%02x%02x%02x", arguments: [convert(r), convert(g), convert(b)])
    }
    convenience init(hex: String) {
        let characterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet().mutableCopy() as! NSMutableCharacterSet
        characterSet.formUnionWithCharacterSet(NSCharacterSet(charactersInString: "#"))
        var string = hex.stringByTrimmingCharactersInSet(characterSet).uppercaseString
        if string.characters.count == 3 {
            string = string.characters.flatMap { "\($0)\($0)" }.joinWithSeparator("")
        }
        if string.characters.count == 6 {
            var rgbValue: UInt32 = 0
            NSScanner(string: string).scanHexInt(&rgbValue)
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0))
        } else {
            self.init(white: 1.0, alpha: 1.0)
        }
    }
}