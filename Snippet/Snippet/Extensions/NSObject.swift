//
//  NSObject.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/3/16.
//  Copyright © 2018年 yzj. All rights reserved.
//

import Foundation
extension SnippetObject where Base: AnyObject {
    @discardableResult
    public func set<T>(_ keypath: ReferenceWritableKeyPath<Base, T>, to value: T) -> SnippetObject {
        base[keyPath: keypath] = value
        return self
    }
}
