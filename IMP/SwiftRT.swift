//
//  Objcc.swift
//  IMP
//
//  Created by Kare on 2018/8/14.
//  Copyright © 2018 kare. All rights reserved.
//

import Foundation

open class SwiftRT<T: NSObject> {
    
    private let anyClass: AnyClass
    private let meteClass: AnyClass
    
    public init() {
        self.anyClass = T.classForCoder()
        self.meteClass = objc_getMetaClass(class_getName(self.anyClass)) as! AnyClass
    }
    
    public var ivars: [String] {
        get {
            var vars = [String]()
            var count: UInt32 = 0
            let ivars = class_copyIvarList(anyClass, &count)
            for i in 0..<Int(count) {
                let ivar = (ivars?[i]).unsafelyUnwrapped
                if let name = ivar_getName(ivar), let type = ivar_getTypeEncoding(ivar) {
                    let result = String(cString: name) + " Type is " + String(cString: type)
                   vars.append(result)
                }
            }
            defer {
                free(ivars)
            }
            return vars
        }
    }
    
    public var properties: [String] {
        get {
            var propers = [String]()
            var count: UInt32 = 0
            let properList = class_copyPropertyList(anyClass, &count)
            for i in 0..<Int(count) {
                if let propertyName = property_getName((properList?[i])!) as UnsafePointer<Int8>? {
                    let key = String(cString: propertyName)
                    propers.append(key)
                }
            }
            defer {
                free(properList)
            }
            return propers
        }
    }
    
    public var protocols: [String] {
        get {
            var protocols = [String]()
            var count: UInt32 = 0
            let protocolist = class_copyProtocolList(anyClass, &count)
            for i in 0..<Int(count) {
                if let protocolName = protocol_getName((protocolist?[i])!) as UnsafePointer<Int8>? {
                    protocols.append(String(cString: protocolName))
                }
            }
            return protocols
        }
    }
    
    public var selectors: [Selector] {
        get {
            var selectors = [Selector]()
            var count: UInt32 = 0
            let selectList = class_copyMethodList(anyClass, &count)
            for i in 0..<Int(count) {
                if let methodSel = method_getName((selectList?[i])!) as Selector? {
                    selectors.append(methodSel)
                }
            }
            defer {
                free(selectList)
            }
            return selectors
        }
    }
    
    public var meteIvars: [String] {
        get {
            var vars = [String]()
            var count: UInt32 = 0
            let ivars = class_copyIvarList(self.meteClass, &count)
            for i in 0..<Int(count) {
                if let name = ivar_getName((ivars?[i])!) {
                    vars.append(String(cString: name))
                }
            }
            defer {
                free(ivars)
            }
            return vars
        }
    }
    
    public var meteProperties: [String] {
        get {
            var propers = [String]()
            var count: UInt32 = 0
            let properList = class_copyPropertyList(self.meteClass, &count)
            for i in 0..<Int(count) {
                if let propertyName = property_getName((properList?[i])!) as UnsafePointer<Int8>? {
                    propers.append(String(cString: propertyName))
                }
            }
            defer {
                free(properList)
            }
            return propers
        }
    }
    
    public var meteProtocols: [String] {
        get {
            var protocols = [String]()
            var count: UInt32 = 0
            let protocolist = class_copyProtocolList(self.meteClass, &count)
            for i in 0..<Int(count) {
                if let protocolName = protocol_getName((protocolist?[i])!) as UnsafePointer<Int8>? {
                    protocols.append(String(cString: protocolName))
                }
            }
            return protocols
        }
    }
    
    public var meteSelectors: [Selector] {
        get {
            var selectors = [Selector]()
            var count: UInt32 = 0
            let selectList = class_copyMethodList(self.meteClass, &count)
            for i in 0..<Int(count) {
                if let methodSel = method_getName((selectList?[i])!) as Selector? {
                    selectors.append(methodSel)
                }
            }
            defer {
                free(selectList)
            }
            return selectors
        }
    }
    
    func addSelector(selector: Selector, from originClass: AnyClass) {
        guard let method = class_getInstanceMethod(originClass, selector),
        let implement = class_getMethodImplementation(originClass, selector),
            let encodingType = method_getTypeEncoding(method) else { return }
        class_addMethod(self.anyClass, selector, implement, encodingType) ? print("Added") : print("exist")
    }
    
    func callMethod(anyClass: AnyClass, selector: Selector,parameter: Any) {
        let imp = class_getMethodImplementation(anyClass, selector)
        typealias ClosureType = @convention(c) (AnyObject, Selector, Any) -> Void
        let dynamicDispatch : ClosureType = unsafeBitCast(imp, to: ClosureType.self)
        dynamicDispatch(anyClass, selector, parameter)
    }
    
    typealias ImplementBlock = @convention(block) () -> Void //(() -> ())
    func addMethod(_ identify: String, imp: ImplementBlock) {
        let ImpBlock = unsafeBitCast(imp, to: AnyObject.self)
        let imp = imp_implementationWithBlock(ImpBlock)
        let selector = NSSelectorFromString(identify)
        let encoding = "v@:f"
        class_addMethod(anyClass, selector, imp, encoding)
    }
}

public class SwiftRTC: NSObject {
    
    private var innerClass: AnyClass
    
    public init(superClass: AnyClass = NSObject.classForCoder()) {
        let uuid = NSUUID().uuidString
        self.innerClass = objc_allocateClassPair(superClass, uuid, 0).unsafelyUnwrapped
    }
    
    public func addIvar(name: String,type: AnyType) {
        let size: Int = 0
        let alignment: Int = 0
        class_addIvar(self.innerClass, name, size, UInt8(alignment), type.rawValue) ? print("yes") : print("NO")
    }
    
    func allocated() -> NSObject {
        objc_registerClassPair(self.innerClass)
        return self.innerClass.alloc() as! NSObject
    }
}

/// CoreFoundation NSObjCRuntime.swift
public enum AnyType: String {
    case ID = "@"
    case Class = "#"
    case Sel = ":"
    case Char = "c"
    case UChar = "C"
    case Short = "s"
    case UShort = "S"
    case Int = "i"
    case UInt = "I"
    case Long = "l"
    case ULong = "L"
    case LongLong = "q"
    case ULongLong = "Q"
    case Float = "f"
    case Double = "d"
    case Bitfield = "b"
    case Bool = "B"
    case Void = "v"
    case Undef = "?"
    case Ptr = "^"
    case CharPtr = "*"
    case Atom = "%"
    case ArrayBegin = "["
    case ArrayEnd = "]"
    case UnionBegin = "("
    case UnionEnd = ")"
    case StructBegin = "{"
    case StructEnd = "}"
    case Vector = "!"
    case Const = "r"
}

public extension NSObject {
    public func performMethod(_ identify: String) {
        perform(NSSelectorFromString(identify))
    }
}
