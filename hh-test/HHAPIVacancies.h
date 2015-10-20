//
//  HHAPIVacancies.h
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHAPIOperation.h"

@interface HHAPIVacancies : HHAPIOperation

- (instancetype)initWithAction:(HHAPIAction *)action andPage:(NSInteger)page andPerPage:(NSInteger)perPage;

- (void)executeSuccess:(void (^) (NSArray *data))success failure:(void (^)(NSError *error))failure;

@end
