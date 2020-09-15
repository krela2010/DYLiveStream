//
//  RecommendPageViewModel.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/13.
//  Copyright © 2020 老刁. All rights reserved.
//

import UIKit



class RecommendPageViewModel {

    var columnData : Property<DYColumnData>?
    var roomListData : Property<DYRoomListData>?
    var anchorListData : Property<DYAnchorListData>?
    init() {
        anchorListData = Property(DYAnchorListData(data: nil))
    }
}
//MARK:-  处理网络请求
extension RecommendPageViewModel {
//    func getRequest() {
//        NetworkTool.request(.GET, "http://capi.douyucdn.cn/api/v1/getColumnList") { (reponse) in
//            let decoder = JSONDecoder()
//            guard let data = reponse.data else {
//                return
//            }
//
//            do {
//                self.columnData?.value = try decoder.decode(DYColumnData.self, from: data)
//
//            }catch{
//                print(error)
//            }
//        }
//    }
    
    func getRoomListWithCategory(_ category:String) {
        
        NetworkTool.request(.GET, "http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=\(category)") { (reponse) in
                  let decoder = JSONDecoder()
                  guard let data = reponse.data else {
                      return
                  }

                  do {
                    self.roomListData?.value = try decoder.decode(DYRoomListData.self, from: data)
                      
                  }catch{
                      print(error)
                  }
              }
    }
    
    func getAnchorListWithOffset(_ offset:Int) {
            
        NetworkTool.request(.GET, "http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=20&offset=\(offset)") { (reponse) in
          let decoder = JSONDecoder()
          guard let data = reponse.data else {
              return
          }

          do {
            let decoder = try decoder.decode(DYAnchorListData.self, from: data)
            
//            self.anchorListData = Property(decoder)
            self.anchorListData?.value = decoder
//            print(decoder)
              
          }catch{
              print(error)
          }
      }
    }
    
    
    func getRecommendCycleViewData(completion:@escaping (RecommendCycleViewListData)->()) {
            
        NetworkTool.request(.GET, "http://capi.douyucdn.cn/api/v1/slide/") { (reponse) in
          let decoder = JSONDecoder()
          guard let data = reponse.data else {
              return
          }
            print(reponse)
          do {
            let decoder = try decoder.decode(RecommendCycleViewListData.self, from: data)
            
//            self.anchorListData?.value = decoder
            print(decoder)
            completion(decoder)
              
          }catch{
              print(error)
          }
      }
    }
    
}

//MARK:-  更新View
//extension RecommendPageViewModel {
////    config
//}

