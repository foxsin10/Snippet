//
//  UIControlSnippet.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit

public typealias SPAction = () -> Void
final fileprivate class EventTrigger {
    let trigger: SPAction?

    init(_ trigger: SPAction?) {
        self.trigger = trigger
    }

    @objc
    func triggered() {
        trigger?()
    }
}

final fileprivate class MutableTrigger {
    private var trigger: SPAction?

    init(_ trigger: SPAction?) {
        self.trigger = trigger
    }

    func update(_  trigger: SPAction?) {
        self.trigger = trigger
    }

    @objc
    func triggered() {
        trigger?()
    }
}

fileprivate struct TriggerEvent {
    static var touchDown: Void?

    static var touchDownRepeat: Void?

    static var touchDragInside: Void?

    static var touchDragOutside: Void?

    static var touchDragEnter: Void?

    static var touchDragExit: Void?

    static var touchUpInside: Void?

    static var touchUpOutside: Void?

    static var touchCancel:  Void?


    static var valueChanged: Void?

    @available(iOS 9.0, *)
    static var primaryActionTriggered: Void?


    static var editingDidBegin: Void?

    static var editingChanged: Void?

    static var editingDidEnd: Void?

    static var editingDidEndOnExit: Void?


    static var allTouchEvents: Void?

    static var allEditingEvents:Void?

    static var applicationReserved: Void?

    static var systemReserved: Void?

    static var allEvents: Void?

}


fileprivate var viewClickKey: Void?
fileprivate let viewClickIdentifier = "viewClickKey"

public extension SnippetObject where Base: UIView {


    @discardableResult
    public func click(_ action: SPAction?) -> SnippetObject {
        
        guard let trigger = objc_getAssociatedObject(base, &viewClickKey) as? MutableTrigger else {
            let trigger: MutableTrigger = .init(action)
            let SEL = #selector(MutableTrigger.triggered)
            var tap = UITapGestureRecognizer.init(target: trigger,
                                                  action: SEL)

            tap.sp.identifier = viewClickIdentifier

            self.base.isUserInteractionEnabled = true
            self.base.addGestureRecognizer(tap)
            objc_setAssociatedObject(self.base,
                                     &viewClickKey,
                                     trigger,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return self
        }

        trigger.update(action)
        return self
    }

}

public extension SnippetObject where Base: UIControl {
    
    @discardableResult
    public func onClick(_ action: (() -> Void)?) -> SnippetObject {
        link(.touchUpInside, for: action)
        return self
    }

    @discardableResult
    public func link(_ event: UIControl.Event, for action: (() -> Void)? = nil) -> SnippetObject {
        var key: Void?
        switch event {
        case .touchDown:
            key = TriggerEvent.touchDown
        case .touchDownRepeat:
            key = TriggerEvent.touchDownRepeat
        case .touchDragInside:
            key = TriggerEvent.touchDragInside
        case .touchDragOutside:
            key = TriggerEvent.touchDragOutside
        case .touchDragEnter:
            key = TriggerEvent.touchDragEnter
        case .touchDragExit:
            key = TriggerEvent.touchDragExit
        case .touchUpInside:
            key = TriggerEvent.touchUpInside
        case .touchUpOutside:
            key = TriggerEvent.touchUpOutside
        case .touchCancel:
            key = TriggerEvent.touchCancel
        case .valueChanged:
            key = TriggerEvent.valueChanged
        case .primaryActionTriggered:
            key = TriggerEvent.primaryActionTriggered
        case .editingDidBegin:
            key = TriggerEvent.editingDidBegin
        case .editingChanged:
            key = TriggerEvent.editingChanged
        case .editingDidEnd:
            key = TriggerEvent.editingDidEnd
        case .editingDidEndOnExit:
            key = TriggerEvent.editingDidEndOnExit
        case .allTouchEvents:
            key = TriggerEvent.allTouchEvents
        case .allEditingEvents:
            key = TriggerEvent.allEditingEvents
        case .applicationReserved:
            key = TriggerEvent.applicationReserved
        case .systemReserved:
            key = TriggerEvent.systemReserved
        case .allEvents:
            key = TriggerEvent.allEvents
        default:
            fatalError("unkown event")
        }

        guard let exTarget = objc_getAssociatedObject(base, &key) as? EventTrigger else {

            let trigger: EventTrigger = .init(action)
            base.addTarget(trigger, action: #selector(EventTrigger.triggered), for: event)
            objc_setAssociatedObject(base,
                                     &key,
                                     trigger,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return self
        }

        base.removeTarget(exTarget, action: #selector(EventTrigger.triggered), for: event)
        let trigger: EventTrigger = .init(action)
        base.addTarget(trigger, action: #selector(EventTrigger.triggered), for: event)
        objc_setAssociatedObject(base,
                                 &key,
                                 trigger,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return self
    }
}
