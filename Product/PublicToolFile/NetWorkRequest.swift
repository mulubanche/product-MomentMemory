//
//  NetWorkRequest.swift
//  LcwangTravel
//
//  Created by 研发部ios专用 on 16/4/7.
//  Copyright © 2016年 lcwang. All rights reserved.
//

import Foundation
import AFNetworking

class NetWorkRequest: AFHTTPSessionManager {
    
    internal static let shareRequest: NetWorkRequest = {
//        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//        manager.requestSerializer.timeoutInterval = 10.f;
//        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        let instance = NetWorkRequest()
        instance.responseSerializer.acceptableContentTypes?.insert("text/html")
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        instance.requestSerializer.willChangeValueForKey("timeoutInterval")
        instance.requestSerializer.timeoutInterval = 10.0 
        instance.requestSerializer.didChangeValueForKey("timeoutInterval")
        return instance
    }()
    
//    func shareRequest() -> NetWorkRequest
//    {
//        let instance = NetWorkRequest()
////        instance.responseSerializer.acceptableContentTypes?.insert("text/html")
////        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
////        return instance
//    }
}