//
//  RFLocationManager.m
//  RoamingFoodie
//
//  Created by Ameya Jathar on 19/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import "RFLocationManager.h"

@interface RFLocationManager ()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocation* currentLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSPointerArray *locationObserverArray;
@end

@implementation RFLocationManager

+(_Nonnull instancetype) sharedManager{
    static RFLocationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if(self != nil) {
        self.locationObserverArray = [NSPointerArray weakObjectsPointerArray];
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 1000; // meters
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
        [self startUpdatingLocation];
    }
    return self;
}

-(void)setDelegate:(id)delegate{
    [self.locationObserverArray addPointer:(__bridge void * _Nullable)(delegate)];
}

- (void)startUpdatingLocation{
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Location service failed with error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray*)locations
{
    CLLocation *location = [locations lastObject];
    self.currentLocation = location;
    [self.locationObserverArray compact];
    for (NSInteger pos = 0; pos<self.locationObserverArray.count; pos++) {
        [((id<RFLocationManagerDelegate>)[self.locationObserverArray pointerAtIndex:pos]) currentLocation:self.currentLocation];
    }
}

@end
