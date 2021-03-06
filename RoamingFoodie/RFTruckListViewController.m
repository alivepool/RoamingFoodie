//
//  RFTruckListViewController.m
//  RoamingFoodie
//
//  Created by Ameya Jathar on 19/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import "RFTruckListViewController.h"
#import "RFTruckDataManager.h"
#import "RFConstants.h"
#import "RFTruckDataModel.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RFLocationManager.h"

@interface RFTruckListViewController ()<UITableViewDelegate, UITableViewDataSource, RFLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *truckTable;
@property(nonatomic, strong)RFTruckDataManager* truckDataManager;
@property(nonatomic, strong)NSMutableArray<RFTruckDataModel*>* truckDataArray;
@end

@implementation RFTruckListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [RFLocationManager sharedManager].delegate = self;
    if (!self.truckDataManager) {
        self.truckDataManager = [RFTruckDataManager sharedManager];
    }
    self.truckDataArray = [self.truckDataManager truckData];
    if (!self.truckDataArray) {
        __weak __typeof__(self) weakSelf = self;
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjects:@[APP_TOKEN] forKeys:@[APP_TOKEN_KEY]];
        [self.truckDataManager fetchTruckDataWithURL:SF_TRUCK_DATA_URL headers:dict success:^(id responseObject) {
            __typeof__(self) strongSelf = weakSelf;
            strongSelf.truckDataArray = responseObject;
            [strongSelf.truckTable reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- TableView Data source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.truckDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    RFTruckDataModel *truckData = [self.truckDataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = truckData.truckOwner;
    cell.detailTextLabel.text = [truckData.foodItems componentsJoinedByString:@","];
    NSString *truckImage = nil;
    if ([truckData.truckType isEqualToString:@"Truck"]) {
        truckImage = @"FoodTruck.png";
    }
    else if ([truckData.truckType isEqualToString:@"Push Cart"]){
        truckImage = @"FoodCart.png";
    }
    
    cell.imageView.image = [UIImage imageNamed:truckImage];
    return cell;
}

#pragma mark -- RFLocationManagerDelegate method
-(void)currentLocation:(CLLocation *)location{
    
}

@end
