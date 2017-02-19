//
//  RKTruckDataManager.h
//  RoamingFoodie
//
//  Created by Ameya Jathar on 19/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFTruckDataManager : NSObject
+(instancetype)sharedManager;
-(void)fetchTruckDataWithURL:(NSString* _Nonnull)urlString headers:(NSMutableDictionary* _Nullable)headers success:(void(^ _Nonnull)(id responseObject))successHandler failure:(void(^ _Nonnull)(NSError *error))failureHandler;
@end
