//
//  AdView.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/15.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit

class AdView: UIView {

    var adImgView = UIImageView()
    var countBtn = UIButton()
    var webURL: String?
    var countTimer: Timer?

    var count: Int? {
         didSet {
            RunLoop.main.add(countTimer!, forMode: .common)
         }
     }
    
    var touchBlock: ((String?) -> ())?
    
    public static func show(touchBlock: @escaping ((String?) -> ())) {
        let view = AdView()
        view.touchBlock = touchBlock
        view.countTimer = Timer.scheduledTimer(timeInterval: 1.0, target: view, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        if let model = AdModel.getLocalModel() {
            if let localPath = model.localPath {
                do {
                    let data = try Data.init(contentsOf: localPath)
                    view.adImgView.image = UIImage.init(data: data)
                    view.countBtn.setTitle("跳过\(model.showTime)", for: .normal)
                    view.webURL = model.webURL
                    view.count = model.showTime
                    let win = UIApplication.shared.keyWindow!
                    win.addSubview(view)
                }catch {
                    self.downloadImage(model: model)
                }
            }else {
                self.downloadImage(model: model)
            }
        }
    }
    
    public static func setValue(imgURL: String!, webURL: String, showTime: NSInteger) {
        if let model = AdModel.getLocalModel() {
            if model.imgURL == imgURL && model.localPath != nil {
                return
            }
        }
        
        let model = AdModel()
        model.imgURL = imgURL
        model.webURL = webURL
        model.showTime = showTime
        self.downloadImage(model: model)
    }
    
    @objc func countDown() {
        guard var count = self.count else {
            return
        }
        count -= 1
        self.count = count
        countBtn.setTitle("跳过\(count)", for: .normal)
        if count == 0 {
            dismissAction()
        }
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: DK.kScreenWidth, height: DK.kScreenHeight))
        self.backgroundColor = UIColor.white
        
        adImgView.frame = self.bounds
        adImgView.isUserInteractionEnabled = true
        adImgView.contentMode = .scaleAspectFill
        adImgView.clipsToBounds = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        adImgView.addGestureRecognizer(tap)
        self.addSubview(adImgView)
        
        let btnW: CGFloat = 60
        let btnH: CGFloat = 30
        countBtn.frame = CGRect(x: DK.kScreenWidth - btnW - 24, y: btnH, width: btnW, height: btnH)
        countBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        countBtn.setTitleColor(.white, for: .normal)
        countBtn.backgroundColor = UIColor.init(white: 0.2, alpha: 0.6)
        countBtn.layer.cornerRadius = 4
        countBtn.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        self.addSubview(countBtn)
    }
    
    @objc func tapAction() {
        if let block = touchBlock {
            block(webURL)
            dismissAction()
        }
    }
    
    @objc func dismissAction() {
        countTimer!.invalidate()
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }, completion: { (_) in
            self.removeFromSuperview()
        })
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func deleteOldImg(localPath: URL?) {
        if let path = localPath {
            do {
                try FileManager.default.removeItem(at: path)
            }catch {
                print(error)
            }
        }
    }
    
    static func downloadImage(model: AdModel) {
        DispatchQueue.global().async {
            do {
                guard let url = URL.init(string: model.imgURL) else {
                    return
                }
                let data = try Data.init(contentsOf: url)
                if let image = UIImage.init(data: data) {
                    do {
                        guard let localPath = model.localPath else {
                            return
                        }
                        try image.pngData()?.write(to: localPath)
                        print("保存成功")
                        model.save()
                    }catch {
                        print(error)
                    }
                }
            }catch {
                
            }
        }
    }
}

    



class AdModel: NSObject {
    var imgURL: String!
    var webURL: String?
    var showTime = 3
    var localPath: URL? {
        get {
            if let url = URL.init(string: imgURL) {
                let imgName = url.lastPathComponent
                return AdModel.filePath(imgName: imgName)
            }
            return nil
        }
    }
    
    static func getLocalModel() -> AdModel? {
        if let dic = UserDefaults.standard.value(forKey: "AdModel") as? [String : String] {
            let model = AdModel()
            model.imgURL = dic["imgURL"]
            model.webURL = dic["webURL"]
            guard let timeString = dic["showTime"], let showTime = NSInteger(timeString) else {
                return nil
            }
            model.showTime = showTime
            return model
        }
        return nil
    }
    
    func save() {
        let dic = ["imgURL" : imgURL, "webURL" : webURL!, "showTime" : "\(showTime)"] as [String : String]
        UserDefaults.standard.set(dic, forKey: "AdModel")
    }
    
    static func filePath(imgName: String) -> URL {
        let cachesPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        let imgPath = URL.init(fileURLWithPath: cachesPath).appendingPathComponent(imgName)
        return imgPath
    }
    
    func deleteOldImage() {
        if let localPath = self.localPath {
            do {
                try FileManager.default.removeItem(at: localPath)
            }catch {
                
            }
        }
    }
}
