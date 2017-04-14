//
//  OXHttpRequest.h
//  yourmessage
//

//

#import <Foundation/Foundation.h>
#import "OXHttpPublic.h"




typedef  NSInteger (^analyzeJsonBlock) (NSDictionary*dict, id* value);

@interface OXHttpRequest : NSObject

@property(nonatomic, copy)NSString* URL;
@property(nonatomic, copy)analyzeJsonBlock block;
@property(nonatomic, copy)NSDictionary *headValue;
@property(nonatomic, assign)NSTimeInterval timeoutInterval;



+(NSString*)makeupRequestURL:(NSString*)strUrl withFunc:(NSString*)strFunc;

- (instancetype)initWithUrl:(NSString*)strUrl;
- (NSString*)makeupRequestURLWithFunc:(NSString*)strFunc;

//CRUDL  (创建, 读取, 更新, 删除, 查询)
//创建(C)
- (void)postRequest:(NSString*)strFunc withParameters:(id)parameters completionWithBlock:(callBackBlock)completionBlock;
//读取(R)
- (void)getRequest:(NSString*)strFunc withParameters:(id)parameters completionWithBlock:(callBackBlock)completionBlock;

//更新(U)
- (void)putRequest:(NSString*)strFunc withParameters:(id)parameters completionWithBlock:(callBackBlock)completionBlock;
- (void)patchRequest:(NSString*)strFunc withParameters:(id)parameters completionWithBlock:(callBackBlock)completionBlock;

//删除(D)
- (void)deleteRequest:(NSString*)strFunc withParameters:(id)parameters completionWithBlock:(callBackBlock)completionBlock;


//虚方法，默认是数据是json格式
- (void)parseResponseResult:(NSDictionary*)resultData completionWithBlock:(callBackBlock)completionBlock;
//需重写，默认是没有错误
- (BOOL)isError:(NSDictionary*)resultDict;
- (NSObject*)getErrorInformation:(NSDictionary*)resultDict;



@end
