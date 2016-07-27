//
//  ObjectFile.h
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface ObjectFile : NSObject

//注册通知
- (void) registerUserNotification;

- (NSArray *)rankingWithData:(NSArray *)dataArr;

- (NSString*) createMd5Sign:(NSDictionary*)dict;

- (NSString *) md5:(NSString *)str;

- (NSString *) valiMobile:(NSString *)mobile;

- (NSString *) retuenTypeName:(NSInteger)num;

- (NSAttributedString *) lableShowHtml:(NSString *)html;

- (NSString *) clearHtmlTab:(NSString *)html;

- (NSString *) addwebHtmlJS:(CGFloat)width;

@end
