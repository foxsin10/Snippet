//
//  TypeInfer.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import Foundation

enum SnippetTypeRefer: String {
    case view = "UIView"
    case label = "UILabel"
    case button = "UIButton"

    func showExampleIdentifier() -> String {
        switch self {
        case .view:
            return "ShowViewSnippetViewController"
        case .label:
            return "ShowLabelSnippetViewController"
        case .button:
            return "ShowButtonSnippetViewController"
        }
    }
}

struct SnippetType {
    let name: SnippetTypeRefer
    let content: String

    static var view: SnippetType {
        return SnippetType.init(name: .view, content: "view config")
    }

    static var label: SnippetType {
        return SnippetType.init(name: .label, content: "attributedText")
    }

    static var button: SnippetType {
        return .init(name: .button, content: "attributedText, onclickEvent")
    }

}
