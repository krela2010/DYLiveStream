//
//  UIView+Extension.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/17.
//  Copyright © 2020 老刁. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
//    logViewHierarchy
    func allSubViews() -> [UIView]
    {
        var subViews:[UIView] = subviews.compactMap{$0}
        subViews.forEach{subViews.append(contentsOf: $0.allSubViews())}
        return subViews
    }
    
    func allSubViews<T>(type: T.Type) -> [T] where T:UIView
    {
//        if
//        :[T] = []
        
        
        var views = subviews.compactMap{
//            views.append($0.allSubViews(type: T.self))
            ($0 is T) ? ($0 as! T) : nil
        }
//        print(views)
        subviews.forEach{views.append(contentsOf: $0.allSubViews(type:T.self))}
        return views
    }
    
    var test:UIView {
            return UIView()
    }
}


extension UIView {
    
    func loadNib() -> Self {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}

//extension UIView
//{
//    var frame:CGRect  {
////        willSet{
////
////        }
////        didSet{
////            print("\(self) : \(frame)")
////            self.frame = newValue
////        }
//        set{
//            self.frame = newValue
//        }
//        get{
//            self.frame
//        }
//    }
//}
