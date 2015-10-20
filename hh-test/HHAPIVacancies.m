//
//  HHAPIVacancies.m
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHAPIVacancies.h"

#define key_param_page @"page"
#define key_param_per_page @"perPage"
#define key_items @"items"

@interface HHAPIVacancies ()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger perPage;

@end

@implementation HHAPIVacancies

- (instancetype)initWithAction:(HHAPIAction *)action andPage:(NSInteger)page andPerPage:(NSInteger)perPage {
    if (self = [super initWithAction:action]) {
        self.page = page;
        self.perPage = perPage;
    }
    
    return self;
}

- (void)executeSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    NSDictionary *parameters = @{key_param_page:@(self.page),
                                 key_param_per_page:@(self.perPage)
                                 };
    NSLog(@"execute with page:%lu and perPage:%lu", (long)self.page, (long)self.perPage);
    [self executeWithParameters:parameters success:^(NSDictionary *data) {
        NSArray *items = data[key_items];
        if (items) {
            success(items);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
