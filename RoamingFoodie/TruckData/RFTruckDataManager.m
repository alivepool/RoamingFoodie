//
//  RKTruckDataManager.m
//  RoamingFoodie
//
//  Created by Ameya Jathar on 19/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import "RFTruckDataManager.h"
#import "RFTruckDataModel.h"
#import <AFNetworking/AFNetworking.h>

@interface RFTruckDataManager()
@property(nonatomic, strong)NSMutableArray *truckDataArray;
@end

@implementation RFTruckDataManager

+(instancetype)sharedManager{
    static RFTruckDataManager* sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(NSMutableArray*)truckData{
    return self.truckDataArray;
}

-(void)fetchTruckDataWithURL:(NSString* _Nonnull)urlString headers:(NSMutableDictionary* _Nullable)headers success:(void(^ _Nonnull)(id responseObject))successHandler failure:(void(^ _Nonnull)(NSError *error))failureHandler{
    
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        for (id key in headers) {
            [manager.requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
        }
        
        [manager GET:urlString parameters:headers progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            __typeof__(self) strongSelf = weakSelf;
            NSMutableArray *truckDataArray = [[NSMutableArray alloc] init];
            for (NSDictionary* dataDict in responseObject) {
                RFTruckDataModel *truckDataModel = [[RFTruckDataModel alloc] init];
                truckDataModel.truckID = [dataDict objectForKey:@"objectid"];
                double latitude = [[dataDict objectForKey:@"latitude"] doubleValue];
                double longitude = [[dataDict objectForKey:@"longitude"] doubleValue];
                truckDataModel.truckLocation = CLLocationCoordinate2DMake(latitude, longitude);
                truckDataModel.truckAddress = [dataDict objectForKey:@"locationdescription"];
                truckDataModel.truckOwner = [dataDict objectForKey:@"applicant"];
                truckDataModel.truckType = [dataDict objectForKey:@"facilitytype"];
                truckDataModel.truckScheduleURL = [dataDict objectForKey:@"schedule"];
                [truckDataArray addObject:truckDataModel];
            }
            strongSelf.truckDataArray = truckDataArray;
            successHandler(truckDataArray);
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            failureHandler(error);
        }];
    });
}
@end
