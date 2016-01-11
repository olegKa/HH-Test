//
//  HHAPIClient.m
//  hh-test
//
//  Created by OLEG KALININ on 19.10.15.
//  Copyright © 2015 OLEG KALININ. All rights reserved.
//

#import "HHAPIClient.h"
#import "AFHTTPRequestOperation.h"

#define _url_ @"https://api.hh.ru"

@interface HHAPIClient ()

@property (nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;

@end

@implementation HHAPIClient

@dynamic reachabilityManager;

+ (instancetype)sharedClient {
    static HHAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HHAPIClient alloc] initWithBaseURL:[NSURL URLWithString:_url_]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        self.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [self.reachabilityManager startMonitoring];
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            //NSLog(@"reachability for domain change to:%ld", (long)status);
        }];
    }
    
    return self;
}

- (void)dealloc {
    [self.reachabilityManager stopMonitoring];
}

/**
 *  Загружает картинку по url. При этом проверяет, если картинка уже в кэше, то читает файл с диска
 *
 *  @param url              url к файлу
 *  @param complectionBlock
 */
- (void)loadImageUrl:(NSString *)url withCompletion:(void (^)(BOOL success, UIImage *image))complectionBlock {
    // find file in cache
    
    NSString *fullPathToFileInCache = [self fullPathToFileInCache:url];
    
    if ([self fileInCache:fullPathToFileInCache]) {
        UIImage *imageFromDisk = [self imageFromFile:fullPathToFileInCache];
        if (imageFromDisk) {
            if (complectionBlock) {
                NSLog(@"image finded in cache");
                complectionBlock(YES, imageFromDisk);
                return;
            }
        }
    }
    
    // file not found in cache. Loading...
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"Response: %@", responseObject);
        
        [self image:responseObject toCache:fullPathToFileInCache];
        
        if (complectionBlock) {
            complectionBlock(YES, responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
        if (complectionBlock) {
            complectionBlock(NO, nil);
        }
    }];
    [requestOperation start];
}


#pragma mark - File System Methods
/**
 *   Ищет файл в кеше
 *
 *  @param fullPathToFile полный путь к файлу
 *
 *  @return полный путь к файлу, если он существует или nil
 */
- (NSString *)fileInCache:(NSString *)fullPathToFile {
    
    NSString *fileInCache;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:fullPathToFile]) {
        fileInCache = fullPathToFile;
    }
    
    return fileInCache;
}

/**
 *  Формирует полный путь к файлу, используя hash полученный из url для формирования имени файла
 *  @param fileName url файла
 *
 *  @return полный путь к файлу
 */
- (NSString *)fullPathToFileInCache:(NSString *)fileName {
    NSString *tmpDir = NSTemporaryDirectory();
    NSString *fullPathToFile = [tmpDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu.img", (unsigned long)[fileName hash]]];
    return fullPathToFile;
}


/**
 *  Возвращает UIImage из файла на диске
 *
 *  @param filePath полный путь к файлу
 *
 *  @return Экземпляр UIImage
 */
- (UIImage *)imageFromFile:(NSString *)filePath {
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    if (!image) {
        NSLog(@"Image not exist with name:%@", filePath);
    }
    return image;
}

/**
 *  Записывает файл на диск (кэширует)
 *
 *  @param image    Экземпляр UIImage
 *  @param filePath полный путь к файлу на диске
 *
 *  @return YES, если записьб прошла успешно. Иначе, NO
 */
- (BOOL)image:(UIImage *)image toCache:(NSString *)filePath {
    BOOL result;
    result = [UIImageJPEGRepresentation((image), 1.0f) writeToFile:filePath atomically:YES];
    return result;
}

@end
