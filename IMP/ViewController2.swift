//
//  ViewController2.swift
//  IMP
//
//  Created by Kare on 2018/8/12.
//  Copyright © 2018 kare. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("viewWillAppear \(type(of: self))")
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("viewDidAppear \(type(of: self))")
//    }
    
    @IBAction func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
