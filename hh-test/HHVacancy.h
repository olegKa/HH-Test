//
//  HHVacancy.h
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHBaseObject.h"
#import "HHEmployer.h"
#import "HHSalary.h"

@interface HHVacancy : HHBaseObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) HHEmployer *employer;
@property (nonatomic, strong) HHSalary *salary;

@end
