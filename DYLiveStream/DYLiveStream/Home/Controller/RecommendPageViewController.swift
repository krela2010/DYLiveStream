//
//  RecommendPageView.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/12.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit

private let kCollectionViewNormalItemH = kCollectionViewItemW - 10
private let kCollectionViewBeautyItemH = kCollectionViewItemW + 10
private let kCollectionViewMargin = 10
private let kCollectionViewItemW = (DK.kScreenWidth - (10 * 3)) / 2
private let kNormalCellID = "kNormalCellID"
private let kBeautyCellID = "kBeautyCellID"
private let kHeaderID = "kHeaderID"

class RecommendPageViewController: UIViewController {

    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Int(kCollectionViewItemW), height: Int(kCollectionViewNormalItemH))
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: CGFloat(DK.kScreenWidth),height: 50.0)
        layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat(kCollectionViewMargin), bottom: 0, right: CGFloat(kCollectionViewMargin))
        
//        layout.dele
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: DK.kScreenWidth, height: self.view.frame.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.de
        collectionView.bounces = false
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCellID)
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderID)
        
        
        collectionView.register(UINib(nibName: "CollectionNormalCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "CollectionViewBeautyCell", bundle: nil), forCellWithReuseIdentifier: kBeautyCellID)
        
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }


}

extension RecommendPageViewController {
    private func setUpUI () {
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .white
    }
}

//MARK:-  代理扩展:UICollectionViewDataSource
extension RecommendPageViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell!

//        cell.contentView.backgroundColor = .cyan
        
        if (indexPath.section == 1) {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBeautyCellID, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    
}

//MARK:-  代理扩展:UICollectionViewDelegate
extension RecommendPageViewController : UICollectionViewDelegate {
//    size
}

//MARK:-  代理扩展:UICollectionViewDelegate
extension RecommendPageViewController : UICollectionViewDelegateFlowLayout {
//    size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.section == 1) {
            return CGSize(width: kCollectionViewItemW, height: kCollectionViewBeautyItemH)
        }
        return CGSize(width: kCollectionViewItemW, height: kCollectionViewNormalItemH)
    }
}
