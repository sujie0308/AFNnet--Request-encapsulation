//
//  Request.m
//  Post
//
//  Created by 苏苏咯 on 2017/4/9.
//  Copyright © 2017年 苏苏咯. All rights reserved.
//

#import "Request.h"
#import "CodeData.h"
#import <MJExtension.h>
@implementation Request
+(void)GetCodebackResult:(callBackBlock)resultBlock
{
    OXHttpRequest * httpRequest=[[OXHttpRequest alloc]initWithUrl:@"XXXXXXXXXXX"];
    httpRequest.timeoutInterval=5;//连接时长，当超出时间返回失败
    httpRequest.block=^NSInteger(NSDictionary *dictSource,id*value)
    {
        CodeData * code = [CodeData mj_objectWithKeyValues:dictSource];
        *value = code;
        return OXHttpRequestResultSuccess;
    };
    NSDictionary *param = @{@"phone":@"XXXXXXXXX",@"flag":@"register",@"app_nonce":@"1321321"};
    
    [httpRequest postRequest:@"api/get_code" withParameters:param completionWithBlock:resultBlock];
}
@end
