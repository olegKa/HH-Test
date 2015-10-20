//
//  HHBaseObject.m
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHBaseObject.h"

#define key_id @"id"

@implementation HHBaseObject

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        self.id = isNull(data[key_id]);
    }
    return self;
}

@end
