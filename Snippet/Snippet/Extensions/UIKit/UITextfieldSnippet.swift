//
//  UITextfieldSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit.UITextField

extension SnippetObject where Base: UITextField {

    public var placeholderColor: UIColor? {
        get {
            return base.value(forKey: "_placeholderLabel.textColor") as? UIColor
        }

        set {
            base.setValue(newValue, forKey: "_placeholderLabel.textColor")
        }
    }

}
