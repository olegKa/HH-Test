//
//  HHPaginator.m
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHPaginator.h"
#import "HHVacancy.h"

#import "HHAPIVacancies.h"

@interface HHPaginator ()
{
    BOOL isWork;
}
/**
 *  Хранилище данных
 */
@property (nonatomic, strong) NSMutableArray<HHVacancy *> *dataSource;

@end

@implementation HHPaginator

+ (instancetype)sharedPaginator {
    static HHPaginator *_sharedPaginator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPaginator = [[HHPaginator alloc] init];
    });
    
    return _sharedPaginator;
}

- (instancetype)init {
    if (self = [super init]) {
        _dataSource = [NSMutableArray new];
        _currentPage = 0;
        _perPage = 20;
    }
    
    return self;
}

- (id)objectAtIndex:(NSInteger)index {
    NSAssert(index < _dataSource.count, @"Index out of bounds paginator");
    return _dataSource[index];
}

- (void)nextPage {
    if (isWork) {
        return;
    }
    
    isWork = YES;
    HHAPIAction *action = [HHAPIAction actionWithMethod:HHAPIActionMethodVacancies];
    HHAPIVacancies *operation = [[HHAPIVacancies alloc] initWithAction:action andPage:self.currentPage andPerPage:self.perPage];
    [operation executeSuccess:^(NSArray *data) {
        [self.delegate paginatorWillChangeContent:self];
        for (NSDictionary *vacancyData in data) {
            HHVacancy *newVacancy = [[HHVacancy alloc] initWithData:vacancyData];
            if (newVacancy) {
                
                [self.dataSource addObject:newVacancy];
                
                [self.delegate paginator:self didChangeObject:newVacancy atIndex:[self.dataSource indexOfObject:newVacancy]];
  
            }
        }
        [self.delegate paginatorDidChangeContent:self];
        self.currentPage ++;
        isWork = NO;
        
    } failure:^(NSError *error) {
        NSLog(@"Request failure with error:%@", error.userInfo);
        isWork = NO;
    }];
    
}


- (NSInteger)count {
    return _dataSource.count;
}


@end
