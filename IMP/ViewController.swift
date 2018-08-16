//
//  ViewController.swift
//  IMP
//
//  Created by Kare on 2018/8/12.
//  Copyright © 2018 kare. All rights reserved.
//

import UIKit

@objc protocol ViewControllerDelegate: NSObjectProtocol {
    func test()
}
//extension UIViewController {
//
//    private enum KeyIdentifys {
//        static var SaveTimeFlg = "SAVETIMEFLG"
//    }
//
//    var currentTime: CFTimeInterval? {
//        get {
//            return objc_getAssociatedObject(self, &KeyIdentifys.SaveTimeFlg) as? CFTimeInterval
//        }
//
//        set {
//            if let nValue = newValue {
//                objc_setAssociatedObject(self, &KeyIdentifys.SaveTimeFlg, nValue as CFTimeInterval, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//            }
//        }
//    }
//
//    static let VCInit: Void = {
//        guard let method_1_1 = class_getInstanceMethod(UIViewController.self, #selector(viewWillAppear(_:))),
//            let method_1_2 = class_getInstanceMethod(UIViewController.self, #selector(sw_viewWillAppear(_:))),
//            let method_2_1 = class_getInstanceMethod(UIViewController.self, #selector(viewDidDisappear(_:))),
//            let method_2_2 = class_getInstanceMethod(UIViewController.self, #selector(sw_viewDidDisappear(_:))) else {
//                return
//        }
//        method_exchangeImplementations(method_1_1, method_1_2)
//        method_exchangeImplementations(method_2_1, method_2_2)
//    }()
//
//    @objc func sw_viewWillAppear(_ animation: Bool) {
//        print("\(type(of: self))")
//        self.currentTime = 0
//        self.currentTime = CACurrentMediaTime()
//    }
//
//    @objc func sw_viewDidDisappear(_ animation: Bool) {
//        let endTime = CACurrentMediaTime() - currentTime!
//        let endTimeStr = String(format: "%.2f", endTime)
//        print("\(type(of: self)) 停留时间： \(endTimeStr)")
//    }
//}

class ViewController: UIViewController, ViewControllerDelegate {
    func test() {
        
    }
    
    weak var delegate: ViewControllerDelegate?
    
    @IBOutlet weak var textFieldText: UITextField!
    
    let goBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.backgroundColor = .blue
        btn.setTitle("GO", for: UIControlState.normal)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 60)
//        btn.addTarget(self, action: #selector(goSecondVC), for: .touchUpInside)
        return btn
    }()
    
    var hh: String = "fasfsfsfssf"
    static let pp = "ffff"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(goBtn)
//        view.backgroundColor = .red
        
        self.textFieldText.setValue(UIColor.red, forKeyPath: "_placeholderLabel.textColor")
//        var count: UInt32 = 0
//        let ivars = class_copyIvarList(ViewController.self, &count)
//        for i in 0..<Int(count) {
//            let ivar = ivars?[i]
//            let property = String(cString: ivar_getName(ivar!)!)
//            print("Instance property \(property)")
//        }
//        free(ivars)
//
//        var classVar: UInt32 = 0
//        let propertyList = class_copyPropertyList(ViewController.self, &classVar)
//        for i in 0..<Int(classVar) {
//            let property = String(cString: property_getName((propertyList?[i])!))
////            print("property \(property)")
//        }
//        free(propertyList)
//        let dd = SwiftRT<ViewController>()
//        print("ob.meteSelectors \(dd.selectors)")
        let tesView = UIView()
        let ob = SwiftRT<UIView>()
        ob.addSelector(selector: #selector(dynamicDispatch(name:)),from: self.classForCoder)
        tesView.responds(to: #selector(dynamicDispatch(name:))) ? print("responsed") : print("not responsed")
        ob.callMethod(anyClass: tesView.classForCoder, selector: #selector(dynamicDispatch(name:)), parameter: ["1","2"])
        
//        print(ob.selectors)
        let identify = "blockTest"
        ob.addMethod(identify) {
            print("\(identify)被调用了")
        }
//        print(ob.selectors)
        tesView.performMethod(identify)
        
//        tesView.performMethod("dynamicDispatchWithname:")
        
//        let vi = ViewController()
//        vi.performMethod("instance_getImp:")
        
//        let selector = #selector(dynamicDispatch(name:))
//        let imp = class_getMethodImplementation(ViewController.self, selector)
//
//        typealias ClosureType = @convention(c) (AnyObject, Selector, String) -> Void
//        let dynamicDispatch : ClosureType = unsafeBitCast(imp, to: ClosureType.self)
//        dynamicDispatch(self, selector, "吃饭了")
        
//        let rtClass = SwiftRTC()
//        rtClass.addIvar(name: "name", type: .ID)
//        let obc = rtClass.allocated()
//        obc.setValue("ivar", forKey: "name")
//        let value = obc.value(forKey: "name")
//        print("value \(value)")
//
//        var selectors = [Selector]()
//        var count: UInt32 = 0
//
//        let className = class_getName(ViewController.self)
//        let mete = objc_getMetaClass(className)
//
//        let selectList = class_copyMethodList(mete as? AnyClass, &count)
//        for i in 0..<Int(count) {
//            let sele = (selectList?[i]).unsafelyUnwrapped
//            if let arguments = method_getName(sele) as Selector? {
//                selectors.append(arguments)
//            }
//        }
//        defer {
//            free(selectList)
//        }
//        print(selectors)
    }
    
    @objc dynamic func dynamicDispatch(name: [String])  {
        print("dynamicDispatch \(name)")
    }
    
    @objc func instance_getImp(_ name: String) {
        print("getImp \(name)")
    }
    
    @objc func instance_goSecondVC() {
//        let selector = #selector(getImp(name:))
//        let imp = class_getMethodImplementation(ViewController.self, selector)
//
//        let method = class_getInstanceMethod(ViewController.self, selector)
//        let imp2 = method_getImplementation(method!)
//
//        typealias ClosureType = @convention(c) (AnyObject, Selector, String) -> Void
//        let sayHiTo : ClosureType = unsafeBitCast(imp2, to: ClosureType.self)
//        sayHiTo(self, selector, "吃饭")
//        return
        
//        let vc2 = ViewController2(nibName: "ViewController2", bundle: nil)
//        self.navigationController?.pushViewController(vc2, animated: true)
//        self.present(vc2, animated: true, completion: nil)
    }
    
    @objc class func class_1() {
        
    }
    
    @objc class func class_1(name: String, pwd: String) {
        
    }
}


