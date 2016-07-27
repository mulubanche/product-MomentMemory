//
//  ObjectFile.m
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

#import "ObjectFile.h"

@implementation ObjectFile

/** 注册APNS */
- (void)registerUserNotification {
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType types = (UIUserNotificationTypeAlert |
                                        UIUserNotificationTypeSound |
                                        UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                   UIRemoteNotificationTypeSound |
                                                                   UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}

- (NSArray *)rankingWithData:(NSArray *)dataArr
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (int i='A'; i<='Z'; i++) {
        
        NSMutableArray *arr = [NSMutableArray array];
        
        BOOL isEquel = YES;
        
        for (NSDictionary *dictItem in dataArr) {
            
            NSString *str = [[dictItem objectForKey:@"index"] substringToIndex:1];
            
            if ([str isEqualToString:[NSString stringWithFormat:@"%c", i]])
            {
                NSMutableDictionary *model = [NSMutableDictionary dictionary];
                
                [model setValue:str forKey:@"title"];
                
                [model setValue:[dictItem objectForKey:@"name"] forKey:@"name"];
                
                [model setValue:[dictItem objectForKey:@"index"] forKey:@"index"];
                
                [arr addObject:model];
            }
        }
        
        if (arr.count == 0)
            isEquel = NO;
        
        if (isEquel) {
            
            //            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            //
            //            [dict setObject:arr forKey:[NSString stringWithFormat:@"%c", i]];
            
            [arr addObject:[NSString stringWithFormat:@"%c", i]];
            
            [dataArray addObject:arr];
        }
    }
    
    
    return dataArray;
}


#pragma mark 同程xml解析方法
-(NSString*) createMd5Sign:(NSDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    
    //拼接字符串
    int i=0;
    for (NSString *categoryId in sortedArray) {
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""] && ![categoryId isEqualToString:@"digitalSign"] && ![categoryId isEqualToString:@"accountKey"]
            )
        {
            [contentString appendFormat:@"%@=%@", categoryId, [dict objectForKey:categoryId]];
            if (i<sortedArray.count-2) {
                [contentString appendString:@"&"];
            }
            i++;
        }
    }
    
    //添加key字段
    [contentString appendFormat:@"%@", @"8df5d96b29b6d7e9"];
    //得到MD5 sign签名
    NSString *md5Sign =[self md5:contentString];
    return md5Sign;
}

- (NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

#pragma mark 判断电话号码
- (NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length != 11)
    {
        return @"手机号长度只能是11位";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入正确的电话号码";
        }
    }
    return nil;
}

- (NSString *) retuenTypeName:(NSInteger)num{
    NSString * productType = @"0";
    switch (num) {
        case 1:
            productType = @"签证";
            break;
        case 2:
            productType = @"邮轮";
            break;
        case 3:
            productType = @"自由行";
            break;
        case 4:
            productType = @"国内";
            break;
        case 5:
            productType = @"出境";
            break;
        case 12:
            productType = @"WiFi";
            break;
        case 7:
            productType = @"酒店";
            break;
        case 8:
            productType = @"景点门票";
            break;
        case 9:
            productType = @"周边游";
            break;
        default:
            break;
    }
    return productType;
}

#pragma mark label显示html
- (NSAttributedString *) lableShowHtml:(NSString *)html{
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attrStr;
}
- (NSString *) clearHtmlTab:(NSString *)html{
    html = [html stringByReplacingOccurrencesOfString:@"<p><br/></p>" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    //let scaletion = CABasicAnimation(keyPath: "transform.scale")
    //scaletion.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    CABasicAnimation *basicanination = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicanination.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    return html;
}

- (NSString *) addwebHtmlJS:(CGFloat)width{
    NSString * js = [NSString stringWithFormat: @"var script = document.createElement('script');"
                     
                     "script.type = 'text/javascript';"
                     
                     "script.text = \"function ResizeImages() { "
                     
                     
                     "var myimg,oldwidth;"
                     
                     "var maxwidth=%f;" //缩放系数
                     
                     "for(i=0;i <document.images.length;i++){"
                     
                     "myimg = document.images[i];"
                     
                     "if(myimg.width > maxwidth){"
                     
                     "oldwidth = myimg.width;"
                     
                     "myimg.width = maxwidth;"
                     
                     "myimg.style.width = maxwidth+'px';"
                     
                     "myimg.height = myimg.height * (maxwidth/oldwidth);"
                     
                     "myimg.style.height = 'auto';"
                     
                     "}"
                     
                     "}"
                     
                     "}\";"
                     
                     "document.getElementsByTagName('head')[0].appendChild(script);",width];
    return js;
}

@end
