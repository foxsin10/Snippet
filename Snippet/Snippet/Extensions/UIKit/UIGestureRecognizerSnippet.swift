//
//  UIGestureRecognizerSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit

fileprivate var spgestureIdentifier: Void?
extension SnippetObject where Base: UIGestureRecognizer {
    public var identifier: String {
        set(newValue) {
            objc_setAssociatedObject(base,
                                     &spgestureIdentifier,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        get {
            guard let id = objc_getAssociatedObject(base, &spgestureIdentifier) as? String else {
                return ""
            }
            return id
        }
    }
}
