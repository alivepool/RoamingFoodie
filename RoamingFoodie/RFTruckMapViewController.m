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

@interface RFTruckMapViewController ()
@property(nonatomic, strong)RFTruckDataManager* truckDataManager;
@property(nonatomic, strong)NSMutableArray* truckDataArray;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation RFTruckMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [RFLocationManager sharedManager];
    if (!self.truckDataManager) {
        self.truckDataManager = [RFTruckDataManager sharedManager];
    }
    
    CLLocationCoordinate2D coord = {.latitude =  37.773972, .longitude =  -122.431297};
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 6000, 6000);
    [self.mapView setRegion:region];
    
    self.truckDataArray = [self.truckDataManager truckData];
    
    
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


@end
