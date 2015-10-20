//
//  HHPaginator.h
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HHVacancy;
@class HHPaginator;

@protocol HHPaginatorDelegate <NSObject>

- (void)paginatorWillChangeContent:(HHPaginator *)paginator;
- (void)paginatorDidChangeContent:(HHPaginator *)paginator;
- (void)paginator:(HHPaginator *)paginator didChangeObject:(id)anObject atIndex:(NSInteger)index;

@end
/**
 *  Менеджер постраничной загрузки
 */
@interface HHPaginator : NSObject

@property (nonatomic, assign) id<HHPaginatorDelegate> delegate;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger perPage;

@property (nonatomic, readonly) NSInteger count;

+ (instancetype)sharedPaginator;

- (id)objectAtIndex:(NSInteger)index;

- (void)nextPage;

@end
