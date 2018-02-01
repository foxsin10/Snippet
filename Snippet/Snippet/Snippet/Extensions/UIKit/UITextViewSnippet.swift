//
//  UITextViewSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit.UITextView


// MARK: - kvc helps 
extension SnippetObject where Base: UITextView {

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

    @discardableResult
    public func set(_ placeholder: String, for color: UIColor) -> SnippetObject {
        if let view = base.value(forKey: "_placeholderLabel") as? UILabel {
            view.removeFromSuperview()
        }

        let label = UILabel()

        label.text = placeholder
        label.numberOfLines = 0
        label.textColor = color
        label.backgroundColor = .clear
        label.font = base.font

        base.addSubview(label)
        base.setValue(label, forKey: "_placeholderLabel")
        return self
    }

    @discardableResult
    public func set(_ placeholder: NSAttributedString,
                    for color: UIColor) -> SnippetObject {

        if let view = base.value(forKey: "_placeholderLabel") as? UILabel {
            view.removeFromSuperview()
        }

        let label = UILabel()

        label.numberOfLines = 0
        label.textColor = color
        label.backgroundColor = UIColor.clear
        label.font = base.font
        label.attributedText = placeholder

        base.addSubview(label)
        base.setValue(label, forKey: "_placeholderLabel")

        return self
    }
}
