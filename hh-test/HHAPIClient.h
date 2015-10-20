//
//  HHAPIClient.h
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "HHAPIClient.h"

@interface HHAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
- (void)loadImageUrl:(NSString *)url withCompletion:(void (^)(BOOL success, UIImage *image))complectionBlock;

@end
