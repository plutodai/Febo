//
//  Common.h
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+(void)showCenterToast:(NSString *)message;

+(void)showBottomToast:(NSString *)message;

+(void)showTopToast:(NSString *)message;

//字符串高度
+ (CGFloat)heightForString:(NSString *)string withFontSize:(CGFloat)fontSize labelWidth:(CGFloat)labelWidth;

//去掉HTML字符串中的标签
+ (NSString *)filterHTML:(NSString *)html;

//检查微博是否对App授权
+ (BOOL)CheckLogin;

@end
