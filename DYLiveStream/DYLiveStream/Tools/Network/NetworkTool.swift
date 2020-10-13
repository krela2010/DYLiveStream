//
//  NetworkTool.swift
//  DYLiveStream
//
//  Created by 老刁 on 2020/9/13.
//  Copyright © 2020 老刁. All rights reserved.
//

import Foundation
import Alamofire
enum HttpMehod{
    case GET
    case POST
}

class NetworkTool {
    class func request(_ method : HttpMehod, _ url:String, completion:@escaping (DataResponse<Any>)->()) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (reponse) in
            completion(reponse)
        })
            
        
   
    }
}





enum  Method {
    case post
    case get
}

extension Method {
    init() {
      self = .get
    }

    init?(_ value: String) {
        switch value.lowercased() {
        case "post": self = .post
        case "get": self = .get
        default: return nil
        }
    }
}
