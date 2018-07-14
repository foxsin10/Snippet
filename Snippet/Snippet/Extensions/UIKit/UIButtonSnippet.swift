//
//  UIButtonSnippet.swift
//  Snippet
//
//  Created by yzj on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit

extension SnippetObject where Base: UIButton {

    @discardableResult
    public func attribute(_ targetString: String,
                          for element: String,
                          color: UIColor,
                          font: UIFont,
                          for state: UIControlState = .normal) -> SnippetObject {

        guard element.count > 0 else {
            return self
        }
       
        guard targetString.contains(element),
              let startIndex = targetString.index(of: element[element.startIndex])   else {
            print("[Snippet Button Attribute]: no element contained")
            return self
        }
        

        let elementRange = NSRange.init(location: startIndex.encodedOffset, length: element.count)

        let attributeString: NSMutableAttributedString = NSMutableAttributedString.init(string: targetString)
        
        let elemntButes: [NSAttributedStringKey: Any] = [
            .font : font,
            .foregroundColor : color
        ]
        
        attributeString.setAttributes(elemntButes, range: elementRange)

        base.setAttributedTitle(attributeString, for: state)

        return self
    }

    @discardableResult
    public func attribute(_ targetString: String, for element: String, with color: UIColor) -> SnippetObject {
        guard let f = base.titleLabel?.font else { return self }
        return attribute(targetString, for: element, color: color, font: f)
    }

   
}
