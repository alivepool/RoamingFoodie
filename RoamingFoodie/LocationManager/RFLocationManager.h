//
//  RFLocationManager.h
//  RoamingFoodie
//
//  Created by Ameya Jathar on 19/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface RFLocationManager : NSObject
@property (strong, nonatomic) CLLocation* currentLocation;
+(_Nonnull instancetype) sharedManager;
@end
