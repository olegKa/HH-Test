//
//  HHAPIOperation.m
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHAPIOperation.h"
#import "HHAPIClient.h"

@implementation HHAPIOperation

- (instancetype)initWithAction:(HHAPIAction *)action {
    if (self = [super init]) {
        _action = action;
    }
    return self;
}

/**
 *  Выполняет GET запрос на сервер с параметрами parameters
 *
 *  @param parameters параметры запроса http://api.hh.ru/?<page=>&<perPage=>
 *  @param success    блок при успехе
 *  @param failure    блок при неудаче
 */
- (void)executeWithParameters:(NSDictionary *)parameters success:(void (^) (NSDictionary *data))success failure:(void (^)(NSError *error))failure {
    HHAPIClient *apiClient = [HHAPIClient sharedClient];
    
    NSLog(@"GET with url:%@", self.action.path);
    
    [apiClient GET:self.action.path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 1 - Попытка десериализации полученных данных и обработка ошибки, если не удалось
        NSError *error = nil;
        id message = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        if (error && message == nil) {
            [self processError:error withFailureBlock:failure];
            return;
        }
        
        // 3 - отправлю результат
        if (success) {
            success(message);
        } else {
            if ([self.delegate respondsToSelector:@selector(operationDone:withData:)]) {
                [self.delegate operationDone:self withData:message];
            }
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self processError:error withFailureBlock:failure];
        
    }];
}


/**
 *  Обработка ошибки через замыкание, или, если замыкание не определено, по протоколу через делегата
 *
 *  @param error        ошибка
 *  @param failureBlock замыкание для обработки ошибки или nil. Тогда ошибка уходит делегату ISAPIOperationDelegate
 */
- (void)processError:(NSError *)error withFailureBlock:(void (^)(NSError *error))failureBlock {
    if (failureBlock) {
        failureBlock(error);
    } else {
        if ([self.delegate respondsToSelector:@selector(operationFailed:withError:)]) {
            [self.delegate operationFailed:self withError:error];
        }
    }
}

#pragma mark - Abstract methods

- (void)executeGET {
    return;
}


@end
