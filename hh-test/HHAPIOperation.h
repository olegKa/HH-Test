//
//  HHAPIOperation.h
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHAPIAction.h"

@class HHAPIOperation;

@protocol HHAPIOperationDelegate <NSObject>

@optional
- (void)operationDone:(HHAPIOperation *)sender withData:(NSDictionary *)data;
- (void)operationFailed:(HHAPIOperation *)sender withError:(NSError *)error;

@end


@interface HHAPIOperation : NSObject

@property (nonatomic, assign) id<HHAPIOperationDelegate> delegate;
@property (nonatomic, strong) HHAPIAction *action;

- (instancetype)initWithAction:(HHAPIAction *)action;

- (void)executeWithParameters:(NSDictionary *)parameters success:(void (^) (NSDictionary *data))success failure:(void (^)(NSError *error))failure;
- (void)executeGET;

@end
