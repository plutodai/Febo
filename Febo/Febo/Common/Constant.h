//
//  Constant.h
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#ifndef Febo_Constant_h
#define Febo_Constant_h

#define WeiboAppKey @"4088152396"
#define WeiboRedirectURL @"http://www.sina.com"

//定义微博授权信息的键
#define WeiboAuthInfo @"WeiboAuthInfo"

//定义屏幕适应
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

//微博消息通知
#define DidGetAccessTokenNotification @"DidGetAccessTokenNotification"
#define DidNotGetAccessTokenNotification @"DidNotGetAccessTokenNotification"

//微博HTTP请求URL
#define GetFriendsTimeline @"https://api.weibo.com/2/statuses/friends_timeline.json"
#define PostNewWeibo @"https://api.weibo.com/2/statuses/update.json"

#endif
