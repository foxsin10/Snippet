//
//  File.swift
//  Snippet
//
//  Created by yzj on 2018/1/31.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit

extension SnippetObject where Base: UIView {

    @discardableResult
    public func apply(_ settingss: (_ v: Base) -> Void) -> SnippetObject {
        settingss(base)
        return self
    }

    @discardableResult
    public func added(to view: UIView) -> SnippetObject {
        view.addSubview(self.base)
        return self
    }

    @discardableResult
    public func layout(_ frame: CGRect) -> SnippetObject {
        self.base.frame = frame
        return self
    }

    @discardableResult
    public func layout(x: CGFloat? = nil,
                       y: CGFloat? = nil,
                       width: CGFloat? = nil,
                       height: CGFloat? = nil) -> SnippetObject {

        var fx: CGFloat = self.base.frame.minX
        var fy = self.base.frame.minY
        var fwidth = self.base.frame.width
        var fheight = self.base.frame.height

        if let tx = x {
            fx = tx
        }

        if let ty = y {
            fy = ty
        }

        if let twidth = width {
            fwidth = twidth
        }

        if let theight = height {
            fheight = theight
        }

        let frame = CGRect.init(x: fx, y: fy, width: fwidth, height: fheight)
        self.base.frame = frame
        return self
    }
}
