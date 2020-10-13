//
//  MenuViewController.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/17.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    @IBOutlet weak var subTitleView: UIView!
    //模拟数据
    private let contentOfRowInSectionArray = [["我的等级","我的空间","免流量特权"],["我的粉丝徽章","我的头衔"],["ADV"],["陪玩大厅","游戏中心","我的语言"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonAttributes:[(String,String)] = [("plus","消息"),("plus","我的任务"),("plus","斗鱼贵族"),("plus","鱼翅充值")]
        
        let view = Bundle.main.loadNibNamed("MenuSubTitleView", owner: nil, options: nil)?.first as! MenuSubTitleView
        view.frame = subTitleView.bounds
 
        
        view.allButtons.forEach { btn in
            btn.setImage(UIImage(named: buttonAttributes[btn.tag].0), for: .normal)
            btn.setTitle(buttonAttributes[btn.tag].1, for: .normal)
        }
        subTitleView.addSubview(view)
        
        tableView.dataSource = self
        tableView.bounces = false
 
    }


}
//MARK:-  扩展代理:UITableViewDataSource
extension MenuViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        contentOfRowInSectionArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if (contentOfRowInSectionArray[indexPath.section][indexPath.row] == "ADV") {
            return createAdvCell()
        }
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellID", for: indexPath)
        cell.textLabel?.text = contentOfRowInSectionArray[indexPath.section][indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentOfRowInSectionArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
}

extension MenuViewController {
    private func createAdvCell()->UITableViewCell {
        let advCell = AdviewCell()
//        let cell = reuser
        advCell.advtisementContent = "plus"
        return advCell
    }
}

