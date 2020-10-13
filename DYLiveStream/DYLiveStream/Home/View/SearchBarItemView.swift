//
//  SearchBarItemView.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/19.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit
//import NibView
class SearchBarItemView: NibView {
    @IBOutlet weak var scanBarView: UIView!
    @IBOutlet weak var scanButton: UIButton!
    override func layoutSubviews() {

        print("layoutSubviews:\(frame)")

    }
    
}
