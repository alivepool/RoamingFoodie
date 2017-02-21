//
//  RKTruckDataModel.h
//  RoamingFoodie
//
//  Created by Ameya Jathar on 19/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface RFTruckDataModel : NSObject
@property(nonatomic, strong)NSString* truckID;
@property(nonatomic, assign)CLLocationCoordinate2D truckLocation;
@property(nonatomic, strong)NSString* truckAddress;
@property(nonatomic, strong)NSString* truckOwner;
@property(nonatomic, strong)NSString* truckType;
@property(nonatomic, strong)NSString* truckScheduleURL;
@property(nonatomic, strong)NSMutableArray* foodItems;
@end
