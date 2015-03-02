//
//  ViewController.m
//  location_reminder_fello
//
//  Created by nacnud on 2/28/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//MARK: handle button presses

- (IBAction)homeButtonPressed:(UIButton *)sender {
    
}

- (IBAction)randomButtonPressed:(UIButton *)sender {
    
}

- (IBAction)codeFellowsButtonPressed:(UIButton *)sender {
    
}
@end
