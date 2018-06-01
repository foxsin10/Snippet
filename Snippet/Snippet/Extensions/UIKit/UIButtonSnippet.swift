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

//        guard element.count > 0 else {
//            return self
//        }
//        
//        guard targetString.contains(element)  else {
//            print("no element contained")
//            return self
//        }

        let baseNString: NSString = .init(string: targetString)
        let elementRange: NSRange = baseNString.range(of: element)

        let attributeString: NSMutableAttributedString = .init(string: targetString)
        
        let elemntButes: [NSAttributedStringKey: Any] = [
            .font : font,
            .foregroundColor : color
        ]
        
        attributeString.addAttributes(elemntButes, range: elementRange)

        base.setAttributedTitle(attributeString, for: state)

        return self
    }

    @discardableResult
    public func attribute(_ targetString: String, for element: String, with color: UIColor) -> SnippetObject {
        guard let f = base.titleLabel?.font else { return self }
        return attribute(targetString, for: element, color: color, font: f)
    }

   
}
