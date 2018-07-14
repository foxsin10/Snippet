//
//  File.swift
//  Snippet
//
//  Created by yzj on 2018/1/31.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit


extension SnippetObject where Base: UIView {

    /// just draw viewcontent in an image
    ///
    /// - Returns: an image
    public func currentshot() -> UIImage? {

        guard #available(iOS 10.0, *) else {
            UIGraphicsBeginImageContextWithOptions(base.bounds.size, false, UIScreen.main.scale)
            guard let contenxt = UIGraphicsGetCurrentContext() else { return nil }
            base.layer.render(in: contenxt)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }

        let format = UIGraphicsImageRendererFormat.init()
        format.scale = UIScreen.main.scale
        let render = UIGraphicsImageRenderer.init(size: base.bounds.size, format: format)

        return render.image(actions: {
            (ctx) in
            self.base.layer.render(in: ctx.cgContext)
        })
    }

    @discardableResult
    public func apply(_ settings: (_ v: Base) -> Void) -> SnippetObject {
        settings(base)
        return self
    }

    @discardableResult
    public func added(to view: UIView) -> SnippetObject {
        view.addSubview(self.base)
        return self
    }

    @discardableResult
    public func add(_ subviews: UIView...) -> SnippetObject {
        subviews.forEach { base.addSubview($0) }
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

        let fx: CGFloat = x ?? self.base.frame.minX
        let fy = y ?? self.base.frame.minY
        let fwidth = width ?? self.base.frame.width
        let fheight = height ?? self.base.frame.height

        let frame = CGRect.init(x: fx, y: fy, width: fwidth, height: fheight)
        self.base.frame = frame
        return self
    }
}
