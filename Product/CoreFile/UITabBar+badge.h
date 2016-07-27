//
//  UITabBar+badge.h
//  LcwangTravel
//
//  Created by 研发部ios专用 on 16/5/5.
//  Copyright © 2016年 lcwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
