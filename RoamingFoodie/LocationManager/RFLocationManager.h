//
//  RFLocationManager.h
//  RoamingFoodie
//
//  Created by Ameya Jathar on 19/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol RFLocationManagerDelegate <NSObject>

-(void)currentLocation:(CLLocation*)location;

@end

@interface RFLocationManager : NSObject
@property (weak, nonatomic)id delegate;
+(_Nonnull instancetype) sharedManager;
@end
