//
//  StringSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/1/31.
//  Copyright © 2018年 yzj. All rights reserved.
//

import Foundation
import UIKit

extension String: SnippetComppatiable {}
extension SnippetObjectProtocol where SOCompatibleType == String {
    @discardableResult
    public func substring(to: Int) -> String {

        let index = base.index(base.startIndex, offsetBy: to)
        let sub = base[base.startIndex ..< index]
        return String.init(sub)

    }

    public func attribute(for element: String,
                          with sets:(color: UIColor, font: UIFont)) -> NSAttributedString? {

        guard base.contains(element) else { return nil }
        
        let baseNString = NSString.init(string: base)
        let elementRange = baseNString.range(of: element)

        let attributeString: NSMutableAttributedString = .init(string: base)

        let elemntButes: [NSAttributedString.Key: Any] = [
            .font : sets.font,
            .foregroundColor : sets.color
        ]

        attributeString.addAttributes(elemntButes, range: elementRange)

        return attributeString
    }
}
