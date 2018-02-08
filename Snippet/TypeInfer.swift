//
//  TypeInfer.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import Foundation

enum ExampleRefer: String {
    case view = "UIView"
    case label = "UILabel"
    case button = "UIButton"
    case textView = "UITextView"

    func showExampleIdentifier() -> String {
        switch self {
        case .view:
            return "ShowViewSnippetViewController"
        case .label:
            return "ShowLabelSnippetViewController"
        case .button:
            return "ShowButtonSnippetViewController"
        case .textView:
            return "ShowTextViewSnippetViewController"
        }
    }
}

struct Example {
    let name: ExampleRefer
    let content: String

    static var view: Example {
        return .init(name: .view, content: "view config")
    }

    static var label: Example {
        return .init(name: .label, content: "attributedText")
    }

    static var button: Example {
        return .init(name: .button, content: "attributedText, onclickEvent")
    }

    static var textView: Example {
        return .init(name: .textView, content: "placeholder")
    }

}
