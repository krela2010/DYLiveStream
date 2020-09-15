//
//  CollectionViewNormalCell.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/12.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewNormalCell: CollectionViewBaseCell {

//    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var anchorImageView: UIImageView!
    @IBOutlet weak var watchingCountLabel: UIButton!
    
    @IBOutlet weak var anchorInfoLabel: UILabel!
    

    override var info : DYAnchorData? {
        didSet{
            guard let info = info else {
                return
            }
//            nickNameLabel.text = info.nickname
            super.info = info
            
            anchorImageView.kf.setImage(with: URL(string: info.vertical_src))
            watchingCountLabel.titleLabel?.text = "\(info.online)"
            anchorInfoLabel.text = info.room_name
            
        }
    }
}
