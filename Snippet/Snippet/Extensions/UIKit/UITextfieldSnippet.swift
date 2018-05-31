//
//  UITextfieldSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import class UIKit.UITextField
import class UIKit.UIColor
import class UIKit.UILabel

extension SnippetObject where Base: UITextField {


    /// return nil when you call this before set placeholder 
    public var placeholderColor: UIColor? {
        get {
            guard let l = base.value(forKey: "_placeholderLabel") else {
                return nil
            }
            guard let label = l as? UILabel  else { return nil }

            return label.textColor
        }

        set {
            guard let label = base.value(forKey: "_placeholderLabel") as? UILabel else {
                return
            }
            guard let color = newValue else { return }
            label.textColor = color
        }
    }

}
