//
//  RFARViewController.m
//  RoamingFoodie
//
//  Created by Ameya Jathar on 20/02/17.
//  Copyright © 2017 Ameya. All rights reserved.
//

#import "RFARViewController.h"
#import "RoamingFoodie-Swift.h"

@interface RFARViewController ()<ARDataSource>
@property(nonatomic, strong)ARViewController *arViewController;
- (IBAction)launchARView:(id)sender;
@end

@implementation RFARViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arViewController = [[NSClassFromString(@"RoamingFoodie.ARViewController") alloc]init];
    self.arViewController.dataSource = self;
    self.arViewController.maxVisibleAnnotations = 30;
    self.arViewController.headingSmoothingFactor = 0.05;
}

-(void)viewWillAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)launchARView:(id)sender {
    [self presentViewController:self.arViewController animated:YES completion:nil];
}

#pragma mark -- ARDataSource Methods

- (ARAnnotationView * _Nonnull)ar:(ARViewController * _Nonnull)arViewController viewForAnnotation:(ARAnnotation * _Nonnull)viewForAnnotation{
    
    ARAnnotationView *view = [[ARAnnotationView alloc] init];
    
    return view;
}
@end
