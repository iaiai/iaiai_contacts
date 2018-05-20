//
//  ContactViewController.swift
//  iaiai_sound
//
//  Created by iaiai on 2018/5/20.
//  Copyright © 2018年 iaiai. All rights reserved.
//

import UIKit
import Contacts

class ContactViewController: UIViewController {
    
    var contact:CNContact?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        var name = ""
        if contact?.familyName != nil{
            name += (contact?.familyName)!
        }
        if contact?.givenName != nil{
            name += (contact?.givenName)!
        }
        self.title = name
    }

}
