//
//  MainContentPageView.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/11.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit

private let cellID = "ReuseCollectionViewCell"

class MainContentPageView: UIView {
    
    private var childVC : [UIViewController]
    private weak var parentVC : UIViewController?
    
    
    init(frame: CGRect, childVC:[UIViewController], parentVC:UIViewController?) {
        self.childVC = childVC
        self.parentVC = parentVC
        super.init(frame: frame)
        setUpUI()

    }
    
    required init?(coder: NSCoder) {
        return nil
    }

    
    private lazy var collectionView : UICollectionView = { [weak self] in
        let collectionViewW = frame.width * CGFloat(childVC.count)
        let collectionViewH = frame.height
        let collectionViewLayout = UICollectionViewFlowLayout()
        //frame.size 和 bounds.size一样
        collectionViewLayout.itemSize = (self?.frame.size ??  CGSize.zero)
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
  

        let collectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout: collectionViewLayout)
        //水平指示线关闭
        collectionView.showsHorizontalScrollIndicator = true;
        //页面样式
        collectionView.isPagingEnabled = true
        //边缘弹性效果关闭
        collectionView.bounces = false

        collectionView.frame = bounds

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()

}

extension MainContentPageView {
    private func setUpUI() {
        setColletionView()
        setUpVC()
    }
    
    private func setColletionView() {
        
      addSubview(collectionView)
        
    }
    
    private func setUpVC() {
        
        for vc in childVC {
            parentVC?.addC
        }
        
    }
}


extension MainContentPageView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVC.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)

        let vc = childVC[indexPath.row]
        vc.view.frame = bounds
        cell.addSubview(vc.view)
        return cell
    }
    
    
}

extension MainContentPageView : UICollectionViewDelegate {
    
}

extension MainContentPageView {
    public func setCurrentCollectionIndex(_ index:Int) {
        let offSet = CGFloat(index) * collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offSet, y: 0), animated: true)
    }
}
