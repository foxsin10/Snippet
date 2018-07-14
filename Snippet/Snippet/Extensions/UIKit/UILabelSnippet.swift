//
//  UILabelSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/1/31.
//  Copyright © 2018年 yzj. All rights reserved.
//

import class UIKit.UILabel
import class UIKit.UIColor
import class UIKit.UIFont
import class UIKit.NSMutableAttributedString
import struct Foundation.NSRange
import class Foundation.NSString
import struct UIKit.NSAttributedStringKey

extension SnippetObject where Base: UILabel {
    @discardableResult
    public func attribute(_ targetString: String, for element: String, with sets:(color: UIColor, font: UIFont)) -> SnippetObject {

//        base.attributedText = nil
        guard targetString.contains(element), let startIndex = targetString.index(of: element[element.startIndex]) else {
            return self
        }

        let elementRange = NSRange.init(location: startIndex.encodedOffset, length: element.count)
        
        let attributeString: NSMutableAttributedString = NSMutableAttributedString.init(string: targetString)
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
