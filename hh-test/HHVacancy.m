//
//  HHVacancy.m
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHVacancy.h"


#define key_vacancy_name        @"name"
#define key_vacancy_employer    @"employer"
#define key_vacancy_salary      @"salary"

@implementation HHVacancy

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        self.name = isNull(data[key_vacancy_name]);
        
        NSDictionary *employerData = isNull(data[key_vacancy_employer]);
        if (employerData && employerData.count) {
            self.employer = [[HHEmployer alloc] initWithData:employerData];
            
        }
        
        NSDictionary *salaryData = isNull(data[key_vacancy_salary]);
        if (salaryData && salaryData.count) {
            self.salary = [[HHSalary alloc] initWithData:salaryData];
        }
    }
    
    return self;
}

@end
