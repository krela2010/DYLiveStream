//
//  RecommendPageView.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/12.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit
import MJRefresh
private let kCollectionViewNormalItemH = kCollectionViewItemW - 10
private let kCollectionViewBeautyItemH = kCollectionViewItemW + 10
private let kCollectionViewMargin = 10
private let kCycleViewHeight = 120
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
        layout.headerReferenceSize = CGSize(width: CGFloat(DK.kScreenWidth),height: 40.0)
        layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat(kCollectionViewMargin), bottom: 0, right: CGFloat(kCollectionViewMargin))
        
//        layout.dele
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: DK.kScreenWidth, height: self.view.frame.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.bounces = true
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderID)

        
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName: "CollectionViewBeautyCell", bundle: nil), forCellWithReuseIdentifier: kBeautyCellID)
        
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.contentInset = UIEdgeInsets(top: CGFloat(kCycleViewHeight), left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    private lazy var recommendCycleView:RecommendCycleView = {
        let view = RecommendCycleView.recommendCycleView()
        view.frame = CGRect(x: 0, y: -CGFloat(kCycleViewHeight), width: self.view.bounds.width, height: CGFloat(kCycleViewHeight))
//        view.backgroundColor = .red

        return view
    }()
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpVM()
        setupRefreshView()
    }


}

extension RecommendPageViewController {
    private func setUpUI () {
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.addSubview(recommendCycleView)
    }
}

//MARK:-  代理扩展:UICollectionViewDataSource
extension RecommendPageViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var cell : UICollectionViewCell!

        let anchor = anchorListData?.data?[indexPath.row];
        if (indexPath.section == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBeautyCellID, for: indexPath) as! CollectionViewBeautyCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
            cell.info = anchor
            return cell
        }

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
   @objc func setUpVM() {

    let dispatchGroup = DispatchGroup()
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
        vm.getRecommendCycleViewData(dispatchGroup) { [weak self] (data) in
            self?.recommendCycleView.list = data
            
        }
        
    dispatchGroup.notify(queue: DispatchQueue.main) {
        self.collectionView.mj_header?.endRefreshing()
    }
    
    }
}

//MARK:-  设置刷新
extension RecommendPageViewController {
    private func setupRefreshView() {
            collectionView.mj_header = MJRefreshNormalHeader()
        guard  let headerHeight = collectionView.mj_header?.frame.height else { return }
        collectionView.mj_header?.setRefreshingTarget(self, refreshingAction: #selector(setUpVM))
        collectionView.mj_header?.ignoredScrollViewContentInsetTop = CGFloat(kCycleViewHeight)
        
    }
}
 
