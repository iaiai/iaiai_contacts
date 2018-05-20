//
//  RecentsViewController.swift
//  iaiai_sound
//
//  Created by iaiai on 2018/5/15.
//  Copyright © 2018年 iaiai. All rights reserved.
//

import UIKit
import CallKit

class RecentsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "通话"
        
//        let callCenter = CTCallCenter()
//        callCenter.callEventHandler = { (call: CTCall) -> Void in
//            if call.callState == CTCallStateDisconnected {
//                print("电话挂断")
//            }
//            if call.callState == CTCallStateConnected {
//                print("电话接通")
//            }
//            if call.callState == CTCallStateIncoming {
//                print("通话途中收到别的来电")
//            }
//            if call.callState == CTCallStateDialing {
//                print("电话播出")
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

