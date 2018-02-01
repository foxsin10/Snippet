//
//  UIButtonSnippet.swift
//  Snippet
//
//  Created by yzj on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit.UIButton



extension SnippetObject where Base: UIButton {

    
    @discardableResult
    public func attribute(_ targetString: String,
                          for element: String,
                          with sets:(color: UIColor, font: UIFont)) -> SnippetObject {

        guard targetString.contains(element) else {
            print("no element contained")
            return self
        }

        base.titleLabel?.attributedText = nil

        let baseNString = targetString as NSString
        let elementRange = baseNString.range(of: element)

        let attributeString: NSMutableAttributedString = .init(string: targetString)

        let elemntButes: [NSAttributedStringKey: Any] = [
            .font : sets.font,
            .foregroundColor : sets.color
        ]

        attributeString.addAttributes(elemntButes, range: elementRange)

        base.titleLabel?.attributedText = attributeString

        return self
    }

    @discardableResult
    public func attribute(_ targetString: String, for element: String, with color: UIColor) -> SnippetObject {
        guard let f = base.titleLabel?.font else { return self }
        return attribute(targetString, for: element, with: (color, f))
    }

   
}
