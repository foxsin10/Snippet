//
//  UILabelSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/1/31.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit.UILabel

extension SnippetObject where Base: UILabel {
    @discardableResult
    public func attribute(_ targetString: String, for element: String, with sets:(color: UIColor, font: UIFont)) -> SnippetObject {

        guard targetString.contains(element), !element.isEmpty else {
            base.text = targetString
            return self
        }

        base.attributedText = nil

        let baseNString = targetString as NSString
        let elementRange = baseNString.range(of: element)

        let attributeString: NSMutableAttributedString = .init(string: targetString)

        let elemntButes: [NSAttributedStringKey: Any] = [
            .font : sets.font,
            .foregroundColor : sets.color
        ]

        attributeString.addAttributes(elemntButes, range: elementRange)

        base.attributedText = attributeString

        return self
    }

    @discardableResult
    public func attribute(_ targetString: String, for element: String, with color: UIColor) -> SnippetObject {
        return attribute(targetString, for: element, with: (color, base.font))
    }
}
