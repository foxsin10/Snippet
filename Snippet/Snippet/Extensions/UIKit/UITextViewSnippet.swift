//
//  UITextViewSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit

// MARK: - kvc helps 
public extension SnippetObject where Base: UITextView {

    public var placeholder: String? {
        guard let label = base.value(forKey: "_placeholderLabel") as? UILabel else { return nil }
        return label.text
    }

    public var attributedPlaceholder: NSAttributedString? {
        if let label = base.value(forKey: "_placeholderLabel") as? UILabel{
            return label.attributedText
        }
        return nil
    }
    
    // this way noneed to adjust the label frame to match the indicator
    @discardableResult
    public func set(placeholder: String, for color: UIColor) -> SnippetObject {
        let config = {
            (v: UILabel) in
            v.text = placeholder
            v.numberOfLines = 0
            v.textColor = color
            v.backgroundColor = .clear
            v.font = self.base.font
        }
        if let view = base.value(forKey: "_placeholderLabel") as? UILabel {
            config(view)
            return self
        }

        let label = UILabel()
        config(label)
        
        base.addSubview(label)
        base.setValue(label, forKey: "_placeholderLabel")
        return self
    }

    @discardableResult
    public func set(placeholder: NSAttributedString, for color: UIColor) -> SnippetObject {

        let config = {
            (v: UILabel) in
            v.numberOfLines = 0
            v.textColor = color
            v.backgroundColor = UIColor.clear
            v.font = self.base.font
            v.attributedText = placeholder
        }

        if let v = base.value(forKey: "_placeholderLabel") as? UILabel {
            config(v)
            return self
        }

        let v = UILabel()
        config(v)


        base.addSubview(v)
        base.setValue(v, forKey: "_placeholderLabel")

        return self
    }
}
