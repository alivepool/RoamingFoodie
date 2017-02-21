//
//  RFARViewController.m
//  RoamingFoodie
//
//  Created by Ameya Jathar on 20/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import "RFARViewController.h"
#import "RoamingFoodie-Swift.h"
#import "RFTruckDataManager.h"
#import "RFTruckDataModel.h"

@interface RFARViewController ()<ARDataSource>
@property(nonatomic, strong)ARViewController *arViewController;
@property(nonatomic, strong)NSMutableArray* truckDataArray;
- (IBAction)launchARView:(id)sender;
@end

@implementation RFARViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arViewController = [[NSClassFromString(@"RoamingFoodie.ARViewController") alloc]init];
    self.arViewController.dataSource = self;
    self.arViewController.maxVisibleAnnotations = 30;
    self.arViewController.headingSmoothingFactor = 0.05;
    
    self.truckDataArray = [[RFTruckDataManager sharedManager] truckData];
    
}

-(void)viewWillAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)launchARView:(id)sender {
    [self presentViewController:self.arViewController animated:YES completion:nil];
    NSMutableArray *annotationArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (RFTruckDataModel* truckModel in self.truckDataArray) {
        ARAnnotation *annotation = [[ARAnnotation alloc] init];
        annotation.title = truckModel.truckOwner;
        annotation.location = [[CLLocation alloc] initWithLatitude:truckModel.truckLocation.latitude longitude:truckModel.truckLocation.latitude];
        [annotationArray addObject:annotation];
    }
    [self.arViewController setAnnotations:annotationArray];
}

#pragma mark -- ARDataSource Methods

- (ARAnnotationView * _Nonnull)ar:(ARViewController * _Nonnull)arViewController viewForAnnotation:(ARAnnotation * _Nonnull)viewForAnnotation{
    
    ARAnnotationView *view = [[ARAnnotationView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.numberOfLines = 0;
    label.text = viewForAnnotation.title;
    [view addSubview:label];
    [view setFrame:CGRectMake(0, 0, 200, 100)];
    view.backgroundColor = [UIColor redColor];
    view.alpha = 0.5;
    
    return view;
}
@end
