//
//  HHAPIVacancies.m
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHAPIVacancies.h"

//#define key_param_page @"page"
//#define key_param_per_page @"perPage"
//#define key_items @"items"

//define has been removed
@interface HHAPIVacancies ()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger perPage;

@end

@implementation HHAPIVacancies

static NSString *const keyParamPage = @"page";
static NSString *const keyParamPerPage = @"perPage";
static NSString *const keyItem = @"items";

- (instancetype)initWithAction:(HHAPIAction *)action andPage:(NSInteger)page andPerPage:(NSInteger)perPage {
    if (self = [super initWithAction:action]) {
        self.page = page;
        self.perPage = perPage;
    }
    
    return self;
}

- (void)executeSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    NSDictionary *parameters = @{keyParamPage:@(self.page),
                                 keyParamPerPage:@(self.perPage)
                                 };
    NSLog(@"execute with page:%lu and perPage:%lu", (long)self.page, (long)self.perPage);
    [self executeWithParameters:parameters success:^(NSDictionary *data) {
        NSArray *items = data[keyItem];
        if (items) {
            success(items);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
