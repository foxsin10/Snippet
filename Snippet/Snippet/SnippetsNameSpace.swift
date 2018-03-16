//
//  SnippetsNameSpace.swift
//  Snippet
//
//  Created by yzj on 2018/1/31.
//  Copyright © 2018年 yzj. All rights reserved.
//

/// inspired by RxSwift

/// protocol for Struct
public protocol SnippetObjectProtocol {
    associatedtype SOCompatibleType
    var base: SOCompatibleType { get }
    init(_ base: SOCompatibleType)
}


public struct SnippetObject<Base>: SnippetObjectProtocol {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}


/// namespace for this repo
public protocol SnippetComppatiable {
    associatedtype SnippetCompatibleType

    static var sp: SnippetObject<SnippetCompatibleType>.Type { get set }
    var sp: SnippetObject<SnippetCompatibleType> { get set }
}

extension SnippetComppatiable {
    public static var sp: SnippetObject<Self>.Type {
        get {
            return SnippetObject<Self>.self
        }
        set {}
    }

    public var sp: SnippetObject<Self> {
        get {
            return SnippetObject(self)
        }
        set {}
    }
}

import Foundation.NSObject
extension NSObject: SnippetComppatiable {}



