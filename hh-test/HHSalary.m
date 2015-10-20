//
//  HHSalary.m
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHSalary.h"

#define key_salary_currency @"currency"
#define key_salary_from @"from"
#define key_salary_to @"to"


@implementation HHSalary

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        self.currency = isNull(data[key_salary_currency]);
        self.from = isNull(data[key_salary_from]);
        self.to = isNull(data[key_salary_to]);
    }
    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString new];
    if (_from) {
        [description appendFormat:@"от %@ ", _from];
    }
    
    if (_to) {
        [description appendFormat:@"до %@ ", _to];
    }
    
    if (_currency) {
        [description appendFormat:@"%@", _currency];
    }
    
    return (description.length > 0)? [description copy]:@"З/П не указана";
    
}

@end
