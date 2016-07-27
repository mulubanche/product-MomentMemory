//
//  NetworkingTools.h
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/25.
//  Copyright © 2016年 molubanche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface NetworkingTools : NSObject

+ (AFHTTPSessionManager *)sharedManager;

@end
