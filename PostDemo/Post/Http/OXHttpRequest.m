//
//  OXHttpRequest.m
//  yourmessage
//

//

#import "OXHttpRequest.h"
#import "AFNetworking.h"

@implementation OXHttpRequest


+(NSString*)makeupRequestURL:(NSString*)strUrl withFunc:(NSString*)strFunc{
    
    NSString* strReturnURL = nil;
    if (strUrl != nil){
        
        //可判断URL是否有效
        NSString* strRequestURL= nil;
        if (strFunc != nil){
            strRequestURL = [[NSString alloc] initWithFormat:@"%@/%@",strUrl, strFunc];
        }
        else{
            strRequestURL = [[NSString alloc] initWithFormat:@"%@",strUrl];
        }
        
        //URL 不能包含 ASCII 字符集中, 不是必须这样的字符进行转义的字符。
        strReturnURL = [strRequestURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    
    return strReturnURL;
}

- (NSString*)makeupRequestURLWithFunc:(NSString*)strFunc{
    return [OXHttpRequest makeupRequestURL:self.URL withFunc:strFunc];
}

- (instancetype)initWithUrl:(NSString*)strUrl{
    self = [super init];
    if (self != nil){
        _URL = [strUrl copy];
    }
    return self;
}

- (AFHTTPSessionManager *)createHTTPRequestOperationManage {
    
    //https 请求
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = securityPolicy;
    
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];


    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    if (self.timeoutInterval > 0){
        manager.requestSerializer.timeoutInterval = self.timeoutInterval;//设置超时时间（多少秒）
    }
    NSString * str =@"text/html";
    //解决服务器没有指定json格式的问题
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: str];
    
    
    if (self.headValue != nil){
        NSArray *arrField = [self.headValue allKeys];
        for (int i=0; i < [arrField count]; i++) {
            NSString* strField = arrField[i];
            if  (strField != nil){
                [manager.requestSerializer setValue:self.headValue[strField] forHTTPHeaderField:strField];
            }
        }
        
    }
   
    return manager;
}


- (void)getRequest:(NSString*)strFunc withParameters:(id)parameters completionWithBlock:(callBackBlock)completionBlock{
    
    NSString *strURL = [self makeupRequestURLWithFunc:strFunc];
    if (![self checkURL:strURL withBlock:completionBlock]){
        return;
    }
    
    AFHTTPSessionManager *manager = [self createHTTPRequestOperationManage];
    
    [manager GET:strURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self parseResponse:task response:responseObject withCompletionBlock:completionBlock];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self parsefailure:task withError:error CompletionBlock:completionBlock];
    }];
}

- (void)postRequest:(NSString*)strFunc withParameters:(id)parameters completionWithBlock:(callBackBlock)completionBlock{
    //[SVProgressHUD show];
     [UIApplication sharedApplication].networkActivityIndicatorVisible =YES;
    NSString *strURL = [self makeupRequestURLWithFunc:strFunc];
    if (![self checkURL:strURL withBlock:completionBlock])
    {
        return;
    }
    
    AFHTTPSessionManager *manager = [self createHTTPRequestOperationManage];
    
    [manager POST:strURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
        
        [self parseResponse:task response:responseObject withCompletionBlock:completionBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self parsefailure:task withError:error CompletionBlock:completionBlock];
    }];
    
}

//更新(U)
- (void)putRequest:(NSString*)strFunc withParameters:(id)parameters completionWithBlock:(callBackBlock)completionBlock{
    
    NSString *strURL = [self makeupRequestURLWithFunc:strFunc];
    if (![self checkURL:strURL withBlock:completionBlock]){
        return;
    }
    
    AFHTTPSessionManager *manager = [self createHTTPRequestOperationManage];
    [manager PUT:strURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self parseResponse:task response:responseObject withCompletionBlock:completionBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self parsefailure:task withError:error CompletionBlock:completionBlock];
    }];

}

- (void)patchRequest:(NSString*)strFunc withParameters:(id)parameters completionWithBlock:(callBackBlock)completionBlock{
    
    NSString *strURL = [self makeupRequestURLWithFunc:strFunc];
    if (![self checkURL:strURL withBlock:completionBlock]){
        return;
    }
    
    AFHTTPSessionManager *manager = [self createHTTPRequestOperationManage];
    [manager PATCH:strURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self parseResponse:task response:responseObject withCompletionBlock:completionBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self parsefailure:task withError:error CompletionBlock:completionBlock];
    }];

}

- (void)deleteRequest:(NSString *)strFunc withParameters:(id)parameters completionWithBlock:(callBackBlock)completionBlock{
    
    NSString *strURL = [self makeupRequestURLWithFunc:strFunc];
    if (![self checkURL:strURL withBlock:completionBlock]){
        return;
    }
    
    AFHTTPSessionManager *manager = [self createHTTPRequestOperationManage];
    [manager DELETE:strURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self parseResponse:task response:responseObject withCompletionBlock:completionBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self parsefailure:task withError:error CompletionBlock:completionBlock];
    }];
}

- (BOOL)checkURL:(NSString *)strURL withBlock:(callBackBlock)completionBlock{

    if (strURL == nil || [strURL isEqualToString:@""]){
        
        if (completionBlock != nil){
            
            OXHttpError *error = [[OXHttpError alloc] init];
            error.errorId = OXHttpRequestResultURLError;
            error.errorDesc = @"URL 格式 错误";
            
            completionBlock(nil, error);
        }
        return NO;
    }
    
    return YES;
}

//请求或网络错误解析
- (void)parsefailure:(NSURLSessionDataTask *)task withError:(NSError *)error CompletionBlock:(callBackBlock)completionBlock{

    if (completionBlock != nil){
        
        NSInteger nError = OXHttpRequestResultNetError;
        //超时
        if (error.code == kCFURLErrorTimedOut){
            nError = OXHttpRequestTimedOut;
            
        }
        //NSDictionary* dictUnderlyingError = error.userInfo[@"NSUnderlyingError"];
       // if (dictUnderlyingError != nil){
            NSString* strFailed = error.userInfo.description;
            if (nil != strFailed && [strFailed rangeOfString:@"unauthorized"].length > 0){
                nError = OXHttpRequestResultUnauthorized;
            }

        //}
        OXHttpError *error = [[OXHttpError alloc] init];
        error.errorId = nError;

        completionBlock(nil, error);
    }
}
//数据解析
- (void)parseResponse:(NSURLSessionDataTask *)task response:(id)responseObject withCompletionBlock:(callBackBlock)completionBlock{

    [self parseResponseResult:(NSDictionary *)responseObject completionWithBlock:completionBlock];
}

//虚方法，默认是数据是json格式
- (void)parseResponseResult:(NSDictionary*)resultData completionWithBlock:(callBackBlock)completionBlock{
    //系统自带JSON解析
    NSDictionary *resultDic = resultData;
    //错误解析
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    OXHttpError *error = [[OXHttpError alloc] init];
    error.errorId = OXHttpRequestResultSuccess;

    if ([self isError:resultDic]){
        NSObject* errorInfo = [self getErrorInformation:resultDic];
        if (completionBlock != nil){
           error.errorId = OXHttpRequestResultDataError;
            completionBlock(errorInfo, error);
        }
        return;
    }
    
    id value = nil;
    //外部的解析处理函数、接口
    if (self.block != nil){
       
        self.block(resultDic, &value);//此返回值是数据，不是请求状态
    }
    
    if (completionBlock != nil){
        completionBlock(value, error);
    }

}
//需重写，默认是没有错误
- (BOOL)isError:(NSDictionary*)resultDict{
    return NO;
}
- (NSObject*)getErrorInformation:(NSDictionary*)resultDict{
    return nil;
}

@end








