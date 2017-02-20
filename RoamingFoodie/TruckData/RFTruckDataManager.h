//
//  RKTruckDataManager.h
//  RoamingFoodie
//
//  Created by Ameya Jathar on 19/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFTruckDataManager : NSObject
+(_Nonnull instancetype)sharedManager;
-(NSMutableArray* _Nullable)truckData;
-(void)fetchTruckDataWithURL:(NSString* _Nonnull)urlString headers:(NSMutableDictionary* _Nullable)headers success:(void(^ _Nonnull)(id _Nonnull responseObject))successHandler failure:(void(^ _Nonnull)(NSError * _Nonnull error))failureHandler;
@end
