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

@interface RFTruckMapViewController ()
@property(nonatomic, strong)RFTruckDataManager* truckDataManager;
@property(nonatomic, strong)NSMutableArray* truckDataArray;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation RFTruckMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.truckDataManager) {
        self.truckDataManager = [[RFTruckDataManager alloc] init];
    }
    
    CLLocationCoordinate2D coord = {.latitude =  37.773972, .longitude =  -122.431297};
    MKCoordinateSpan span = {.latitudeDelta =  1, .longitudeDelta =  1};
    MKCoordinateRegion region = {coord, span};
    [self.mapView setRegion:region];
    
    __weak __typeof__(self) weakSelf = self;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjects:@[APP_TOKEN] forKeys:@[@"$$app_token"]];
    [self.truckDataManager fetchTruckDataWithURL:SF_TRUCK_DATA_URL headers:dict success:^(id responseObject) {
        __typeof__(self) strongSelf = weakSelf;
        strongSelf.truckDataArray = [NSMutableArray arrayWithArray:responseObject];
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
