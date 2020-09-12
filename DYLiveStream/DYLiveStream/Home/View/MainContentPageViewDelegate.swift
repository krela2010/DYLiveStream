//
//  MainContentPageViewDelegate.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/12.
//  Copyright © 2020 老刁. All rights reserved.
//

import Foundation
import UIKit
@objc  protocol MainContentPageViewDelegate where Self : UIViewController {
    @objc optional func pageContentView(_ pageView : MainContentPageView, _ index : Int)
}
