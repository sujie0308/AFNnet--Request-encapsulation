//
//  CodeData.h
//  PAy-4-6
//
//  Created by user on 16/4/25.
//  Copyright © 2016年 zhongjinlian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeData : NSObject
@property (copy, nonatomic)NSString *data;
@property (copy, nonatomic)NSString *errormsg;
@property (assign, nonatomic)BOOL success;
@property (copy, nonatomic)NSString *statuscode;
@end
