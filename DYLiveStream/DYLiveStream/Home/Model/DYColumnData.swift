//
//  DYColumnData.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/13.
//  Copyright © 2020 老刁. All rights reserved.
//

import Foundation


struct DYColumnData : Codable {
    var data : [DYData]
}

struct DYData : Codable {
    var cate_id:String
    var cate_name:String
    var push_ios:String
    var push_nearby:String
    var push_show:String
    var push_vertical_screen:String
    var short_name:String
}


struct DYRoomListData : Codable {
    var data : [DYRoomData]
}

struct DYRoomData : Codable {
    var tag_id:String
    var short_name:String
    var tag_name:String
    var tag_introduce:String
    var pic_name:String
    var pic_name2:String
    var icon_name:String
    var small_icon_name:String
    var orderdisplay:String
    var rank_score:String
    var night_rank_score:String
    var nums:String
    var push_ios:String
    var push_home:String
    var pic_url:String
    var icon_url:String
    var small_icon_url:String

    
//    var push_vertical_screen:String
//    var short_name:String
}


struct DYAnchorListData : Codable {
    var data : [DYAnchorData]?
}

struct DYAnchorData : Codable {
    var room_id:String
    var room_src:String
    var vertical_src:String
    var isVertical:Int
    var cate_id:Int
    var room_name:String
    var show_status:String
    var show_time:String
    var owner_uid:String
    var nickname:String
    var game_name:String
    var avatar_mid:String
    var avatar_small:String
    var anchor_city:String

}
