//
//  HHEmployer.m
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHEmployer.h"

#define key_employer_name @"name"
#define key_employer_logo @"logo_urls"
#define key_employer_logo_240 @"240"

@implementation HHEmployer

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        self.name = isNull(data[key_employer_name]);
        if (isNull(data[key_employer_logo])) {
            self.logo = isNull(data[key_employer_logo][key_employer_logo_240]);
        }
    }
    
    return self;
}

@end
