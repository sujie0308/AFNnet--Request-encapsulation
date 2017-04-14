//
//  OXHttpError.h
//  UM
//
//  Created by ND-Eric on 15-2-15.
//
//

#import <Foundation/Foundation.h>


@interface OXHttpError : NSObject

@property(nonatomic, assign)NSInteger errorId;//错误ID
@property(nonatomic, copy)NSString* errorDesc;//错误信息

@end
