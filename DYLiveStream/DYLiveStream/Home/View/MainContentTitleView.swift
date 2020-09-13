//
//  MainContentTitleView.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/11.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit

//创建主页面标题栏
fileprivate let kScrollViewHeight = 3


class MainContentTitleView: UIView {

    //标题内容
    let titles : [String]
    var titleLabels : [UILabel] = [UILabel]()
    var currentLabelIndex : Int = 1
    weak var delegate : MainContentTitleViewDelegate?
    //标题栏滚动条
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.frame = frame
        return scrollView
    }()
    
    //滚动状态条
    private lazy var scrollLine : UIView = {
        return UIView()
    }()
    
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setUpUI()
    }
    //防止调用
    required init?(coder: NSCoder) {

        return nil
        
    }
}

extension MainContentTitleView {
    private func setUpUI() {
        addSubview(scrollView)
        //设置滚动条
        setUpScrollView()
        //设置滚动条内Label
        setUpTitleLabels()
        //设置滚动条内下标线
        setUpScollLine()
    }
    
    private func setUpScrollView () {
            addSubview(scrollView)
    }
    
    private func setUpTitleLabels () {
        for(index, value) in titles.enumerated() {
            let label = UILabel()
            
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.text = value
            label.textColor = .white
            label.textAlignment = .center
            
            let labelW:CGFloat = frame.width / CGFloat(titles.count)
            let labelH:CGFloat = frame.height - CGFloat(kScrollViewHeight)
            let labelX:CGFloat = labelW * CGFloat(index)
            let labelY:CGFloat = 0
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelClicked(_:)))
            label.addGestureRecognizer(tapGesture)
        }
    }
    
    private func setUpScollLine () {
        guard let label = titleLabels.first else {
            return
        }
        
        scrollLine.backgroundColor = .gray
        scrollLine.frame = CGRect(x: label.frame.origin.x, y: (frame.height - CGFloat(kScrollViewHeight)), width: label.frame.width, height: CGFloat(kScrollViewHeight))
        
        scrollView.addSubview(scrollLine)
        
    }
    

}


extension MainContentTitleView {
    @objc func titleLabelClicked(_ gesture:UIGestureRecognizer){
        
        guard let label = gesture.view as? UILabel else {
            return
        }
        label.textColor = .gray
        titleLabels[currentLabelIndex].textColor = .white
        currentLabelIndex = label.tag
        
        let scrollLineX = CGFloat(currentLabelIndex) * scrollLine.frame.width
        #warning("todo 平滑效果")
        UIView.animate(withDuration: 0.5) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView?(self, currentLabelIndex)
        
    }
}


//MARK:-  外部接口
extension MainContentTitleView {
    public func setCurrentScrollIndex(_ index:Int) {
        let offSet = CGFloat(index) * scrollLine.bounds.width
        UIView.animate(withDuration: 0.1) {
            self.scrollLine.frame.origin.x = offSet
        }
        
    }
}
