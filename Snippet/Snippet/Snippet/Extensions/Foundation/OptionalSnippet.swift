//
//  OptionalSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import Foundation

extension Optional: SnippetComppatiable {}
extension SnippetObjectProtocol where SOCompatibleType == Optional<String> {
    public var wrapped: String {
        guard let s = base else { return "" }
        return s
    }
}
