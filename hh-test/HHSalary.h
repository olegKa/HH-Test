//
//  HHSalary.h
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHBaseObject.h"

@interface HHSalary : HHBaseObject

@property (nonatomic, strong) NSNumber *from;
@property (nonatomic, strong) NSNumber *to;
@property (nonatomic, strong) NSString *currency;

@end
