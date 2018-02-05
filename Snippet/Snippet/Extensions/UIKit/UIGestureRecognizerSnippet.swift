//
//  UIGestureRecognizerSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit.UIGestureRecognizer

fileprivate var SpGesGestureRecognizerIdentifier: Void?
extension SnippetObject where Base: UIGestureRecognizer {
    public var identifier: String {
        set(newValue) {
            objc_setAssociatedObject(base,
                                     &SpGesGestureRecognizerIdentifier,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        get {
            guard let id = objc_getAssociatedObject(base, &SpGesGestureRecognizerIdentifier) as? String else {
                return ""
            }
            return id
        }
    }
}
