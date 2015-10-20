//
//  HHAPIAction.h
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, HHAPIActionMethod) {
    HHAPIActionMethodUnknown,
    HHAPIActionMethodVacancies
};
/**
 *  Хелпер для формирования строки запроса с методом api
 */
@interface HHAPIAction : NSObject

/**
 *  основной метод, например vacancies
 */
@property (nonatomic, assign) HHAPIActionMethod mainMethod;
/**
 *  в текущей реализации не используется.
 */
@property (nonatomic, assign) HHAPIActionMethod detailMethod;

/**
 *  может использоваться для передачи ID объекта для получения деталей. Нпример, https://api.hh.ru/vacancies/8252535
 */
@property (nonatomic, assign) NSUInteger objectId;

@property (nonatomic, readonly) NSString *path;

+ (instancetype)actionWithMethod:(HHAPIActionMethod)method;
+ (instancetype)actionWithActionMainMethod:(HHAPIActionMethod)mainMethod forObjectId:(NSUInteger)objectId andDetailMethod:(HHAPIActionMethod)detailMethod;

- (instancetype)initWithActionMainMethod:(HHAPIActionMethod)mainMethod forObjectId:(NSUInteger)objectId andDetailMethod:(HHAPIActionMethod)detailMethod;


@end
