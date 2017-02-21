//
//  ViewController.m
//  RoamingFoodie
//
//  Created by Ameya Jathar on 18/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import "RFTruckMapViewController.h"
#import "RFConstants.h"
#import "RFTruckDataModel.h"
#import "RFTruckDataManager.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RFLocationManager.h"
#import "RoamingFoodie-Swift.h"

@interface RFTruckMapViewController ()<RFLocationManagerDelegate>
@property(nonatomic, strong)RFTruckDataManager* truckDataManager;
@property(nonatomic, strong)NSMutableArray* truckDataArray;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation RFTruckMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [RFLocationManager sharedManager].delegate = self;
    if (!self.truckDataManager) {
        self.truckDataManager = [RFTruckDataManager sharedManager];
    }
    
    self.truckDataArray = [self.truckDataManager truckData];
    
    [self setMapRegionWithLat:SF_LAT long:SF_LON latMeter:SF_REGION_RADIUS lonMeter:SF_REGION_RADIUS];
    
    if (!self.truckDataArray) {
        __weak __typeof__(self) weakSelf = self;
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjects:@[APP_TOKEN] forKeys:@[APP_TOKEN_KEY]];
        [self.truckDataManager fetchTruckDataWithURL:SF_TRUCK_DATA_URL headers:dict success:^(id responseObject) {
            __typeof__(self) strongSelf = weakSelf;
            strongSelf.truckDataArray = responseObject;
            for (RFTruckDataModel* truckDataModel in strongSelf.truckDataArray) {
                MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                point.coordinate = truckDataModel.truckLocation;
                point.title = truckDataModel.truckOwner;
                [strongSelf.mapView addAnnotation:point];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMapRegionWithLat:(double)lat long:(double)lon latMeter:(double)latM lonMeter:(double)lonM{
    CLLocationCoordinate2D coord = {.latitude =  lat, .longitude =  lon};
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, latM, lonM);
    [self.mapView setRegion:region];
}

#pragma mark -- RFLocationManagerDelegate method
-(void)currentLocation:(CLLocation *)location{
    [self setMapRegionWithLat:location.coordinate.latitude long:location.coordinate.longitude latMeter:SF_FOCUSED_REGION_RADIUS lonMeter:SF_FOCUSED_REGION_RADIUS];
}

@end
