//
//  ViewController.swift
//  LogLib
//
//  Created by QH-QuocHuynh on 08/28/2022.
//  Copyright (c) 2022 QH-QuocHuynh. All rights reserved.
//

import UIKit
import LogLib

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Log.out(state: .info, msg: "Log is info", showHierarchy: true)
        Log.out(state: .todo, msg: "Log is todo", showHierarchy: true)
        Log.out(state: .url, msg: "Log is url")
        Log.out(state: .warning, msg: "Log is warnning")
        Log.out(state: .error, msg: "Log is error")
        Log.out(state: .success, msg: "Log is success")
    }
}
