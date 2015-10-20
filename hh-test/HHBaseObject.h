//
//  HHBaseObject.h
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHBaseObject : NSObject

@property (nonatomic, strong) NSString *id;

- (instancetype)initWithData:(NSDictionary *)data;

@end
