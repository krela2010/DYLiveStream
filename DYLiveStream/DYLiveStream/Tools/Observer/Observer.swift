//
//  Observer.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/13.
//  Copyright © 2020 老刁. All rights reserved.
//

import Foundation


class Property<Type> {
    
//    private var subscribeAction :((Type?) -> ())?
    private var subscribeAction : (Type?) -> () = {_ in }
    
    func subscribe(_ closure:@escaping (Type?) -> ()) {
        subscribeAction = closure

        if let value = value {
            self.subscribeAction(value)
        }
    }
//
    var value :Type? {
        didSet {
            subscribeAction(value)
        }
    }
    
    init(_ v :Type) {
        value = v
    }
    
}
