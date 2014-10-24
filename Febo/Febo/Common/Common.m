//
//  Common.m
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "Common.h"

@implementation Common

+(void)showCenterToast:(NSString *)message
{
    [[[UIApplication sharedApplication] keyWindow] makeToast:message duration:1.5 position:@"center"];
}

+(void)showBottomToast:(NSString *)message
{
    [[[UIApplication sharedApplication] keyWindow] makeToast:message duration:1.5 position:@"bottom"];
}

+(void)showTopToast:(NSString *)message
{
    [[[UIApplication sharedApplication] keyWindow] makeToast:message duration:1.5 position:@"top"];
}

+ (CGFloat)heightForString:(NSString *)string withFontSize:(CGFloat)fontSize labelWidth:(CGFloat)labelWidth
{
    CGSize actualSize = [string boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return actualSize.height;
}

+ (NSString *)filterHTML:(NSString *)html
{
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
    return html;
}

+ (BOOL)CheckLogin
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:WeiboAuthInfo]){
        NSDate *currentDate = [NSDate date];
        NSDate *expirationDate = [[[NSUserDefaults standardUserDefaults] objectForKey:WeiboAuthInfo] objectForKey:@"expirationDate"];
        if ([expirationDate compare:currentDate] == NSOrderedDescending) {
            NSLog(@"还没过期");
            return YES;
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:DidNotGetAccessTokenNotification object:nil];
            return NO;
        }
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:DidNotGetAccessTokenNotification object:nil];
        return NO;
    }
}

@end
