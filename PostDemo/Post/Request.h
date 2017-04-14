//
//  Request.h
//  Post
//
//  Created by 苏苏咯 on 2017/4/9.
//  Copyright © 2017年 苏苏咯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OXHttpRequest.h"
@interface Request : NSObject
+(void)GetCodebackResult:(callBackBlock)resultBlock;
@end
