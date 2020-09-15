//
//  RecommendCycleView.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/14.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit
import Kingfisher
private let kCycleCellID = "kCycleCellID"
class RecommendCycleView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var list: RecommendCycleViewListData? {
        didSet {
            pageControl.numberOfPages = list?.data.count ?? 0
            collectionView.reloadData()
        }
    }
    override func layoutSubviews() {
         let layout = UICollectionViewFlowLayout()
            layout.itemSize = bounds.size
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
            collectionView.isPagingEnabled = true
            collectionView.collectionViewLayout = layout
            collectionView.bounces = false
            
    }
    


}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView{

        let view = Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView

        view.collectionView.register(UINib(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        return view
    }
}

//MARK:-  代理扩展:UICollectionViewDataSource
extension RecommendCycleView :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionViewCycleCell

        cell.data = list?.data[indexPath.row]
        return cell
    }
    
    
}
//MARK:-  代理扩展:UICollectionViewDelegate
extension RecommendCycleView :UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        3
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x + scrollView.frame.width * 0.5
        
        pageControl.currentPage = Int(offset / scrollView.frame.width)
    }
    
    
}
