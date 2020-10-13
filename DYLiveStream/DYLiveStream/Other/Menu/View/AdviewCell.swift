//
//  AdviewCell.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/18.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit

class AdviewCell: UITableViewCell {
//    @IBOutlet weak var imageView: UIImageView!

  
//    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var advtisementContent:String? {
        didSet{
//            contentView.
            if let content = advtisementContent {
                imageView?.image = UIImage(named: content)
            }
        }
    }
    
//    init(adv:String) {
////        if let content = advtisementContent {
////        super.
//        super.init()
////        self.imageView?.image = UIImage(named: adv)
////        }
//    }
    
//    required init?(coder: NSCoder) {
//        super.init(coder:coder)
//        fatalError("init(coder:) has not been implemented")
//    }
    
}
