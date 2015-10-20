//
//  HHAPIAction.h
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, HHAPIActionMethod) {
    HHAPIActionMethodUnknown,
    HHAPIActionMethodVacancies
};

@interface HHAPIAction : NSObject

@property (nonatomic, assign) HHAPIActionMethod mainMethod;
@property (nonatomic, assign) HHAPIActionMethod detailMethod;
@property (nonatomic, assign) NSUInteger objectId;

@property (nonatomic, readonly) NSString *path;

+ (instancetype)actionWithMethod:(HHAPIActionMethod)method;
+ (instancetype)actionWithActionMainMethod:(HHAPIActionMethod)mainMethod forObjectId:(NSUInteger)objectId andDetailMethod:(HHAPIActionMethod)detailMethod;

- (instancetype)initWithActionMainMethod:(HHAPIActionMethod)mainMethod forObjectId:(NSUInteger)objectId andDetailMethod:(HHAPIActionMethod)detailMethod;


@end
