//
//  DYColumnData.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/13.
//  Copyright © 2020 老刁. All rights reserved.
//

import Foundation


struct DYColumnData : Codable {
    let data : [DYData]
}

struct DYData : Codable {
    let cate_id:String
    let cate_name:String
    let push_ios:String
    let push_nearby:String
    let push_show:String
    let push_vertical_screen:String
    let short_name:String
}


struct DYRoomListData : Codable {
    let data : [DYRoomData]
}

struct DYRoomData : Codable {
    let tag_id:String
    let short_name:String
    let tag_name:String
    let tag_introduce:String
    let pic_name:String
    let pic_name2:String
    let icon_name:String
    let small_icon_name:String
    let orderdisplay:String
    let rank_score:String
    let night_rank_score:String
    let nums:String
    let push_ios:String
    let push_home:String
    let pic_url:String
    let icon_url:String
    let small_icon_url:String

    
//    let push_vertical_screen:String
//    let short_name:String
}


struct DYAnchorListData : Codable {
    let data : [DYAnchorData]?
}

struct DYAnchorData : Codable {
    let room_id:String
    let room_src:String
    let vertical_src:String
    let isVertical:Int
    let cate_id:Int
    let room_name:String
    let show_status:String
    let show_time:String
    let owner_uid:String
    let nickname:String
    let game_name:String
    let avatar_mid:String
    let avatar_small:String
    let anchor_city:String
    let online:Int

}


struct DYRecommendCycleListData : Codable {
    let data : [DYRecommendCycleData]?
}

struct DYRecommendCycleData : Codable {
    let room_id:String
    let room_src:String
    let vertical_src:String
    let isVertical:Int
    let cate_id:Int
    let room_name:String
    let show_status:String
    let show_time:String
    let owner_uid:String
    let nickname:String
    let game_name:String
    let avatar_mid:String
    let avatar_small:String
    let anchor_city:String
    let online:Int

}




// MARK: - RecommendCycleViewData
struct RecommendCycleViewListData: Codable {
    let error: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
//    let mainID : Int
//    let id:Int
    let id, main_id, source, oa_source: Int
    let title: String
    let pic_url, tv_pic_url: String
//    let room: Room

//    enum CodingKeys: String, CodingKey {
//        case id
//        case mainID
//        case source
//        case oaSource
//        case title
//        case picURL
//        case tvPicURL
//        case room
//    }
}

//// MARK: - Room
//struct Room: Codable {
//    let roomID: String
//    let roomSrc, verticalSrc: String
//    let isVertical: Int
//    let cateID, roomName, vodQuality, showStatus: String
//    let showTime, ownerUid, specificCatalog, specificStatus: String
//    let creditIllegal, isWhiteList, curCredit, lowCredit: String
//    let online: Int
//    let nickname, url, gameURL, gameName: String
//    let gameIconURL: String
//    let showDetails: String
//    let ownerAvatar: String
//    let cdnsWithName: [CdnsWithName]
//    let isPassPlayer, openFullScreen: Int
//    let nrt, ownerWeight, fans, columnID: String
//    let cateLimit: CateLimit
//
//    enum CodingKeys: String, CodingKey {
//        case roomID
//        case roomSrc
//        case verticalSrc
//        case isVertical
//        case cateID
//        case roomName
//        case vodQuality
//        case showStatus
//        case showTime
//        case ownerUid
//        case specificCatalog
//        case specificStatus
//        case creditIllegal
//        case isWhiteList
//        case curCredit
//        case lowCredit
//        case online, nickname, url
//        case gameURL
//        case gameName
//        case gameIconURL
//        case showDetails
//        case ownerAvatar
//        case cdnsWithName
//        case isPassPlayer
//        case openFullScreen
//        case nrt
//        case ownerWeight
//        case fans
//        case columnID
//        case cateLimit
//    }
//}
//
//// MARK: - CateLimit
//struct CateLimit: Codable {
//    let limitType, limitNum, limitThreshold, limitTime: Int
//
//    enum CodingKeys: String, CodingKey {
//        case limitType
//        case limitNum
//        case limitThreshold
//        case limitTime
//    }
//}
//
//// MARK: - CdnsWithName
//struct CdnsWithName: Codable {
//    let name: Name
//    let cdn: CDN
//}
//
//enum CDN: String, Codable {
//    case tct = "tct"
//    case ws = "ws"
//    case ws2 = "ws2"
//}
//
//enum Name: String, Codable {
//    case 主线路 = "主线路"
//    case 备用线路2 = "备用线路2"
//    case 备用线路5 = "备用线路5"
//}
