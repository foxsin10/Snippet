//
//  DictionarySnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/4/17.
//  Copyright © 2018年 yzj. All rights reserved.
//

import Foundation
extension Dictionary: SnippetComppatiable {}
public extension SnippetObjectProtocol where SOCompatibleType == Dictionary<String, String> {
    public func trace() {
        
    }
}
