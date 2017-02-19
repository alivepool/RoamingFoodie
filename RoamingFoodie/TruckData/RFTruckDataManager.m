//
//  RKTruckDataManager.m
//  RoamingFoodie
//
//  Created by Ameya Jathar on 19/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import "RFTruckDataManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation RFTruckDataManager
-(void)fetchTruckDataWithURL:(NSString* _Nonnull)urlString headers:(NSMutableDictionary* _Nullable)headers success:(void(^ _Nonnull)(id responseObject))successHandler failure:(void(^ _Nonnull)(NSError *error))failureHandler{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    for (id key in headers) {
        [manager.requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
    }
    
    [manager GET:urlString parameters:headers progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failureHandler(error);
    }];
}
@end
