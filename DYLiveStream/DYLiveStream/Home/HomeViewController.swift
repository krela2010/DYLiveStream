//
//  HomeViewController.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/10.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController {

//    懒加载
    
    /// 获取navigationBar高度
    private lazy var navigationBarHeight = {
        return navigationController?.navigationBar.frame.height
    }()
    /// 创建pageView
    
    private lazy var mainContentPageView:MainContentPageView = { [weak self] in

        var childVC : [UIViewController] = [UIViewController]()

        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVC.append(vc)
        }
        
        let pageViewY = DK.kStatusBarHeight + (navigationBarHeight ?? 0) + DK.kPageTitleViewHeight
        let pageViewH = (self?.view.frame.height)! - pageViewY
        let pageView = MainContentPageView(frame: CGRect(x: 0, y: DK.kPageTitleViewHeight, width: DK.kScreenWidth, height: pageViewH), childVC: childVC, parentVC:self)
        return pageView

    }()
    /// 创建titleView
    private var mainContentTitleView:MainContentTitleView = {
        let titleView = MainContentTitleView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: DK.kPageTitleViewHeight), titles: ["游戏","游戏","游戏","游戏"])
        titleView.backgroundColor = .orange
        
        return titleView
    }()
    
    /// 加载界面
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarItem()
        setUpTitleView()
        setUpPageView()
    }
}

extension HomeViewController {
    
    private func setUpNavigationBarItem() {

        let button = UIButton()
        
        button.setImage(UIImage(named: "searchBarIcon"), for: .normal)
        button.setImage(UIImage(named: "searchBar"), for: .highlighted)
        button.sizeToFit()

        let barItem1 = UIBarButtonItem(imageName: "plus", highlightImageName: "plus", size: CGSize(width:10, height:10))
        let barItem2 = UIBarButtonItem(imageName: "plus", highlightImageName: "plus", size: CGSize(width:10, height:10))

//        navigationController?.navigationBar.frame.height
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)

        navigationItem.rightBarButtonItems = [barItem1,
               barItem2]
        
        
        
    }
    
    private func setUpBarItem() {
        
    }
    
    private func setUpTitleView() {
        view.addSubview(mainContentTitleView)
        mainContentTitleView.delegate = self
    }
    
    private func setUpPageView() {
         
        view.addSubview(mainContentPageView)
//        mainContentPageView.backgroundColor = .systemPink
        
    }
}


extension HomeViewController : MainContentTitleViewDelegate {
    func pageTitleView(_ titleView: MainContentTitleView, _ index: Int) {
        mainContentPageView.setCurrentCollectionIndex(index)
    }
    
}
