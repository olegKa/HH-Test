//
//  HHAPIAction.m
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHAPIAction.h"

#define method_vacancies @"vacancies"

@implementation HHAPIAction

+ (instancetype)actionWithMethod:(HHAPIActionMethod)method {
    HHAPIAction *action = [[HHAPIAction alloc] initWithActionMainMethod:method forObjectId:0 andDetailMethod:HHAPIActionMethodUnknown];
    return action;
}

+ (instancetype)actionWithActionMainMethod:(HHAPIActionMethod)mainMethod forObjectId:(NSUInteger)objectId andDetailMethod:(HHAPIActionMethod)detailMethod {
    HHAPIAction *action = [[HHAPIAction alloc] initWithActionMainMethod:mainMethod forObjectId:objectId andDetailMethod:detailMethod];
    return action;
}

- (instancetype)initWithActionMainMethod:(HHAPIActionMethod)mainMethod forObjectId:(NSUInteger)objectId andDetailMethod:(HHAPIActionMethod)detailMethod {
    if (self = [super init]) {
        _mainMethod = mainMethod;
        _objectId = objectId;
        _detailMethod = detailMethod;
    }
    
    return self;
}

#pragma mark - Properties
- (NSString *)path {
    NSString *path = @"";
    if (self.mainMethod != HHAPIActionMethodUnknown) {
        path = [path stringByAppendingPathComponent:[self methodForAction:self.mainMethod]];
        if (self.objectId > 0) {
            path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu", (unsigned long)self.objectId]];
            if (self.detailMethod != HHAPIActionMethodUnknown) {
                path = [path stringByAppendingPathComponent:[self methodForAction:self.detailMethod]];
            }
        }
    }
    
    return path;
}

#pragma mark - Private methods
- (NSString *)methodForAction:(HHAPIActionMethod)action {
    NSString *method;
    switch (action) {
        case HHAPIActionMethodVacancies:
            method = method_vacancies;
            break;
                default:
            NSAssert(NO, @"Unknown method for ISAPIAction");
            break;
    }
    return method;
}



@end
