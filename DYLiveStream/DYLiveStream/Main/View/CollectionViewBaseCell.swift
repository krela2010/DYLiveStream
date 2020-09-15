//
//  CollectionViewBaseCell.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/14.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit

class CollectionViewBaseCell: UICollectionViewCell {
    @IBOutlet weak var nickNameLabel: UILabel!
    
       var info : DYAnchorData? {
            didSet{
                guard let info = info else {
                    return
                }
                
                nickNameLabel.text = info.nickname

                
            }
        }
}
