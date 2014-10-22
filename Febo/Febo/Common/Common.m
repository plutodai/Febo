//
//  Common.m
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (CGFloat)heightForString:(NSString *)string withFontSize:(CGFloat)fontSize labelWidth:(CGFloat)labelWidth
{
    CGSize actualSize = [string boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return actualSize.height;
}

@end
