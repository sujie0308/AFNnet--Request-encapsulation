//
//  OXHttpPublic.h
//  contact
//

//

#ifndef contact_OXHttpPublic_h
#define contact_OXHttpPublic_h
#import "OXHttpError.h"

//nState: 返回的状态
//id:返回的数据
typedef  void (^callBackBlock) (id value, OXHttpError* error);

typedef NS_ENUM(NSInteger, OXHttpRequestResult) {
    
    OXHttpRequestResultSuccess,//成功 默认从0开始
    OXHttpRequestResultURLError,//URL错误
    OXHttpRequestResultDataError,//数据错误
    OXHttpRequestResultUnauthorized,//没有授权
    OXHttpRequestResultNetError,//网络原因出错了
    OXHttpRequestResultSectionTimeout,//section 超时了，得重新登录
    OXHttpRequestTimedOut,//请求超时
};

#endif
