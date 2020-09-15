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
private let infiniteSize = 10000000

class RecommendCycleView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var listSize:Int?  {
        get{
            return list?.data.count ?? nil
        }
    }
    
    var timer:Timer?
    
    var list: RecommendCycleViewListData? {
        didSet {
            pageControl.numberOfPages = listSize ?? 0
            guard let size = listSize, size > 0 else {
                return
            }
            let midIndexPath = IndexPath(row: infiniteSize / size / 2 * size, section: 0)
             collectionView.scrollToItem(at: midIndexPath,
                                              at: .centeredHorizontally,
                                        animated: false)
            collectionView.reloadData()
            removeTimer()
            addTimer()
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
        infiniteSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionViewCycleCell

        guard let size = listSize else {
            return cell
        }
        
        cell.data = list?.data[indexPath.row % size]
        return cell
    }
    
    
}
//MARK:-  代理扩展:UICollectionViewDelegate
extension RecommendCycleView :UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x + scrollView.frame.width * 0.5
    
        guard let size = listSize else {
            return
        }
        pageControl.currentPage = Int(offset / scrollView.frame.width) % size
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset.x + scrollView.frame.width * 0.5
//    }
    
}
//MARK:-  设置timer,自动滚动
extension RecommendCycleView {
    private func addTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
//            self?.scrollToNext()
//        })
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
//        RunLoop.main
    }
    
    @objc private func scrollToNext() {
        let nexPageOffset = collectionView.contentOffset.x + bounds.width

        collectionView.setContentOffset(CGPoint(x: nexPageOffset, y: 0), animated: true)
    
    }
    
    private func removeTimer() {
        timer?.invalidate()
    }
}
