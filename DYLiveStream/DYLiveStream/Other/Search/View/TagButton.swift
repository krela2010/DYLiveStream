//
//  tagButton.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/21.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit

class TagButton: UIButton {
    
    init(_ text:String, frame:CGRect) {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(text, for: .normal)
        
        layer.cornerRadius = 10
        layer.borderWidth = 0.6
        layer.borderColor = UIColor.gray.cgColor
        setTitleColor(.black, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 10)
        sizeToFit()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
