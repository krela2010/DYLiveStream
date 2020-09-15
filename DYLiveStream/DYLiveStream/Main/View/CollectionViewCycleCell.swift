//
//  CollectionViewCycleCell.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/15.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit

class CollectionViewCycleCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var anchorInfoLabel: UILabel!
    
    var data:Datum? {
        didSet{
 
            
            imageView.kf.setImage(with: URL(string: data?.pic_url ?? ""))
            anchorInfoLabel.text = data?.title
        }
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

}
