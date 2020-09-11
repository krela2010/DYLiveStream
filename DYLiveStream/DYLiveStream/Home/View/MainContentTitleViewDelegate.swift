//
//  MainContentTitleViewDelegate.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/11.
//  Copyright © 2020 老刁. All rights reserved.
//

import Foundation
import UIKit
@objc  protocol MainContentTitleViewDelegate where Self : UIViewController {
    @objc optional func pageTitleView(_ titleView : MainContentTitleView, _ index : Int)
}
