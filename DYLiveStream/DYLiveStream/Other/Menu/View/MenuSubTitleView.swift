//
//  MenuSubTitleView.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/17.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit

class MenuSubTitleView: UIView {

    @IBOutlet weak var chargeButton: UIButton!
    @IBOutlet weak var missionButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var nobelButton: UIButton!
    
    lazy var allButtons:[UIButton] = {
        let buttons = allSubViews(type: UIButton.self)
        _ = buttons.map {
            $0.setTitle("", for: .normal)
            $0.setImage(UIImage(named: "plus"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 20, right: 0)
            $0.titleEdgeInsets = UIEdgeInsets(top: CGFloat(buttonImageHeight), left: -38, bottom: 0, right: 0)
        }

        return buttons
    }()
    private let buttonImageHeight = 40

}
