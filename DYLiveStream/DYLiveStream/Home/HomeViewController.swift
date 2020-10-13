//
//  HomeViewController.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/10.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController {
    
    // 获取navigationBar高度
    private lazy var navigationBarHeight = {
        return navigationController?.navigationBar.frame.height
    }()
    // 创建pageView
    private lazy var mainContentPageView:MainContentPageView = { [weak self] in

        var childVC : [UIViewController] = [UIViewController]()

        let vc = RecommendPageViewController()
        
        childVC.append(vc)
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVC.append(vc)
        }
        
        let pageViewY = DK.kStatusBarHeight + (navigationBarHeight ?? 0) + DK.kPageTitleViewHeight
        let pageViewH = (self?.view.frame.height)! - pageViewY
        let pageView = MainContentPageView(frame: CGRect(x: 0, y: DK.kPageTitleViewHeight, width: DK.kScreenWidth, height: pageViewH) , childVC: childVC, parentVC:self)
        return pageView

    }()
    
    // 创建titleView
    private var mainContentTitleView:MainContentTitleView = {
        let titleView = MainContentTitleView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: DK.kPageTitleViewHeight), titles: ["游戏","游戏","游戏","游戏"])
        titleView.backgroundColor = .orange
        
        return titleView
    }()
    
    // 创建搜索栏
    private lazy var searchBarView:SearchBarItemView = {
        let view = SearchBarItemView().loadNib()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        view.scanButton.addTarget(self, action: #selector(scanButtonTaped), for: .touchUpInside)
        
        view.scanButton.addTarget(self, action: #selector(scanButtonTaped), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scanBarViewTaped))
        view.scanBarView.addGestureRecognizer(tapGesture)

        return view
    }()
    
    // 加载界面
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpNavigationBarItem()
        setUpTitleView()
        setUpPageView()
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(menuBarTaped), for: .touchUpInside)


        navigationItem.titleView = UIView(frame: CGRect(x: 0,y: 0,width: 200,height: 40))
        navigationItem.titleView?.addSubview(searchBarView)


        navigationItem.rightBarButtonItems = [barItem1, barItem2]

    }
    
    private func setUpBarItem() {
        
    }
    
    private func setUpTitleView() {
        view.addSubview(mainContentTitleView)
        mainContentTitleView.delegate = self
    }
    
    private func setUpPageView() {
         
        view.addSubview(mainContentPageView)
        mainContentPageView.delegate = self
        
    }
    
    private func setUpLayout() {
        view.autoresizesSubviews = false
    }
}

//MARK:- 代理扩展:MainContentTitleViewDelegate
extension HomeViewController : MainContentTitleViewDelegate {
    func pageTitleView(_ titleView: MainContentTitleView, _ index: Int) {
        mainContentPageView.setCurrentCollectionIndex(index)
    }
    
}
//MARK:- 代理扩展:MainContentTitleViewDelegate
extension HomeViewController : MainContentPageViewDelegate {
    func pageContentView(_ titleView: MainContentPageView, _ index: Int) {
        mainContentTitleView.setCurrentScrollIndex(index)
    }
    
}

//MARK:-  点击事件
extension HomeViewController
{
    @objc func menuBarTaped() {
        print("menuBarTaped")
        performSegue(withIdentifier: "goToMenu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMenu" {
            guard let vc = segue.destination as? MenuViewController else { return }
            vc.hidesBottomBarWhenPushed = true
        }
    }
    //扫码功能
    @objc func scanButtonTaped() {
        print("scanButtonTaped")
        
//        let vc = ScanViewController(nibName: "ScanViewController", bundle: nil)
//        vc.hidesBottomBarWhenPushed = true
//
//        navigationController?.pushViewController(vc, animated: false)

    }
    
    //搜索功能
    @objc func scanBarViewTaped() {
        print("scanBarViewTaped")

        
        let vc = SearchViewController(nibName: "SearchViewController", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
