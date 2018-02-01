//
//  StringSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/1/31.
//  Copyright © 2018年 yzj. All rights reserved.
//

import Foundation

extension String: SnippetComppatiable {}
extension SnippetObjectProtocol where SOCompatibleType == String {
    @discardableResult
    public func substring(to: Int) -> String {

        guard to >= 0 else {
            return base
        }
        guard to <= base.count else {
            return base
        }

        let index = base.index(base.startIndex, offsetBy: to)
        return String(base[base.startIndex ..< index])

    }

}
