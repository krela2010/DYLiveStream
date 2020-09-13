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

    var columnData : DYColumnData?
    var roomListData : DYRoomListData?
    var anchorListData : DYAnchorListData?
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
        
        
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "CollectionViewBeautyCell", bundle: nil), forCellWithReuseIdentifier: kBeautyCellID)
        
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpVM()
//
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
//        var cell : UICollectionViewCell!

        let anchor = anchorListData?.data?[indexPath.row];
        if (indexPath.section == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBeautyCellID, for: indexPath) as! CollectionViewBeautyCell
//            cell.
//            cell.info = anchor
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
            cell.info = anchor
            return cell
        }
//        return cell
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


//MARK:-  设置viewModel通信
extension RecommendPageViewController {
    func setUpVM() {

        
        let vm = RecommendPageViewModel()
        vm.columnData?.subscribe({
            guard let data = $0 else { return }
          self.columnData = data
        })
        
        vm.roomListData?.subscribe({
            guard let data = $0 else { return }
          self.roomListData = data
        })

        vm.anchorListData?.subscribe({
            guard let data = $0 else { return }
          self.anchorListData = data
          self.collectionView.reloadData()
        })
        vm.getRoomListWithCategory("xsl")
        vm.getAnchorListWithOffset(0)
    }
}
