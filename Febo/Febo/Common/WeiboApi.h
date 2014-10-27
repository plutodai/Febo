//
//  WeiboApi.h
//  Febo
//  定义微博接口
//  Created by YY on 14/10/27.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#ifndef Febo_WeiboApi_h
#define Febo_WeiboApi_h

#pragma mark 微博普通读取接口

//微博HTTP请求URL
#define GetFriendsTimeline @"https://api.weibo.com/2/statuses/friends_timeline.json"
#define PostNewWeibo @"https://api.weibo.com/2/statuses/update.json"

/*
 返回最新的200条公共微博，返回结果非完全实时
 请求方式：GET
 需要登录：否
 请求参数：
                 必选     类型                          说明
source          false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
count           false	int     单页返回的记录条数，最大不超过200，默认为20。
 */
#define PiblicTimeline @"https://api.weibo.com/2/statuses/public_timeline.json"


/*
获取最新的提到登录用户的微博列表，即@我的微博
 请求方式：GET
 需要登录：是
 请求参数：
                     必选     类型                          说明
 source             false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 access_token       false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 since_id           false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 max_id             false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 count              false	int     单页返回的记录条数，最大不超过200，默认为20。
 page               false	int     返回结果的页码，默认为1。
 filter_by_author	false	int     作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0。
 filter_by_source	false	int     来源筛选类型，0：全部、1：来自微博、2：来自微群，默认为0。
 filter_by_type     false	int     原创筛选类型，0：全部微博、1：原创的微博，默认为0。
 */
#define Mentions @"https://api.weibo.com/2/statuses/mentions.json"

#endif
