//
//  SearchViewController.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/21.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    
//    @IBOutlet weak var tableView: UITableView!
    
//    private lazy var testView :UIView = {
//            let i = SearchTagView(frame: CGRect(x: 0, y: 40, width: DK.kScreenWidth, height: 60))
//
//        i.backgroundColor = .blue
//
//        return i
//    }()
    
    
    private lazy var fixedHeaderView :UIView = {
        let fixedHeaderView = SearchTagView(frame: CGRect(x: 0, y: 40, width: DK.kScreenWidth, height: 60))
//        fixedHeaderView.frame = CGRect(x: 0, y: 40, width: DK.kScreenWidth, height: 60)
                
                let button1 = TagButton("标签", frame: CGRect(x: 0, y: 0, width: 20, height: 10))
                
                
                
                let button2 = TagButton("标签123343", frame: CGRect(x: 20, y: 0, width: 20, height: 10))
                
                
                let button3 = TagButton("btb标签123343", frame: CGRect(x: 20, y: 0, width: 20, height: 10))
                
        //        button1.frame.height = CGFloat(40)
                let viewsDictionary = ["button1": button1, "button2": button2, "button3": button3]

                fixedHeaderView.addSubview(button1)
                fixedHeaderView.addSubview(button2)
                fixedHeaderView.addSubview(button3)
                
                fixedHeaderView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[button1]-[button2]-[button3]", options: [], metrics: nil, views: viewsDictionary))
        
        _ = viewsDictionary.map{ (key: String, value: TagButton) in
            fixedHeaderView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[\(key)]-15-|", options: [], metrics: nil, views: viewsDictionary))
            //            fixedHeaderView.backgroundColor = .red
        }
//        _ = viewsDictionary.map extractedExpr
//                fixedHeaderView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|-[button1]-|", options: [], metrics: nil, views: viewsDictionary))
                fixedHeaderView.backgroundColor = .red
        



                return fixedHeaderView
    }()
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect(origin: CGPoint(x: 0, y: 104), size: view.bounds.size) , style: .plain)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        view = UIView(frame: )
        contentView.autoresizesSubviews = false

        contentView.addSubview(tableView)
        contentView.addSubview(fixedHeaderView)
        
        
        tableView.delegate = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    override func viewDidLayoutSubviews() {
//        print(fixedHeaderView.frame)
//        print(fixedHeaderView.superview?.frame)
//        print(view.frame)
    }



}

extension SearchViewController : UITableViewDelegate {
    
}

extension SearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight:CGFloat = 60;

        let originY:CGFloat = 44

//        if (tableView.contentOffset.y >= 0)
//        {
            UIView.animate(withDuration: 0) {
//                let y = self.fixedHeaderView.frame.origin.y
                let y = max(0, originY - self.tableView.contentOffset.y)
                print(y)
                self.fixedHeaderView.frame.origin = CGPoint(x: 0, y: y)
            }
//
//
//        }else  if((-scrollView.contentOffset.y) >= sectionHeaderHeight) {
//
////            print(fixedHeaderView.frame.origin)
//            UIView.animate(withDuration: 0) {
//                self.fixedHeaderView.frame.origin = CGPoint(x:0, y:((-self.tableView.contentOffset.y) + sectionHeaderHeight))
//            }
//
//        }

    }
    
    
}
