//
//  UIBarButtonItem+Extension.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/11.
//  Copyright © 2020 老刁. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    convenience init(imageName:String, highlightImageName:String, size:CGSize = CGSize(width: 0, height: 0)) {

        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))

        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highlightImageName), for: .highlighted)
        if (size != CGSize(width: 0, height: 0)) {
            let horizontalInsets = max((btn.frame.size.width - size.width)/2, 0)
            let verticalInsets = max((btn.frame.size.width - size.height)/2, 0)

            btn.imageEdgeInsets = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        }

        self.init(customView:btn)
    }
}
