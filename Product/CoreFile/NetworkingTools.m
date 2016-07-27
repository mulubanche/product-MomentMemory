//
//  NetworkingTools.m
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/25.
//  Copyright © 2016年 molubanche. All rights reserved.
//

#import "NetworkingTools.h"

@implementation NetworkingTools

+ (AFHTTPSessionManager *)sharedManager{
    static AFHTTPSessionManager * manager = nil;
    if (!manager) {
        manager = [AFHTTPSessionManager manager];
    }
    
    return manager;
}

@end
