//
//  UIColor+Extension.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/11.
//  Copyright © 2020 老刁. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    convenience init (r:CGFloat, g:CGFloat, b:CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
