//
//  ViewController.m
//  location_reminder_fello
//
//  Created by nacnud on 2/28/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//MARK: handle button presses

- (IBAction)homeButtonPressed:(UIButton *)sender {
    CLLocationCoordinate2D homeCoordinate = CLLocationCoordinate2DMake(47.039199, -122.897258);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = MKCoordinateRegionMake(homeCoordinate, span);
    [self.mapView setRegion:region animated:true];
    
}


-(CLLocationDegrees) randomLat{
    double rand = (double) arc4random();
    double maxUint = (double) UINT_MAX;
    double negOneToOne = ((rand/maxUint) * 2) -1;
    double randomLat = negOneToOne*90;
    NSLog(@"random latitude: %f", randomLat);
    CLLocationDegrees latDegree = randomLat;
    return latDegree;
}

-(CLLocationDegrees) randomLong{
    double rand = (double) arc4random();
    double maxUint = (double) UINT_MAX;
    double negOneToOne = ((rand/maxUint) * 2) -1;
    double randomLat = negOneToOne*180;
    NSLog(@"random longitude: %f", randomLat);
    CLLocationDegrees latDegree = randomLat;
    return latDegree;
}

- (IBAction)randomButtonPressed:(UIButton *)sender {
    CLLocationCoordinate2D cord = CLLocationCoordinate2DMake([self randomLat], [self randomLong]);
    MKCoordinateSpan span = MKCoordinateSpanMake(10, 10);
    MKCoordinateRegion region = MKCoordinateRegionMake(cord, span);
    [self.mapView setRegion:region animated:true];
    
}

- (IBAction)codeFellowsButtonPressed:(UIButton *)sender {
    CLLocationCoordinate2D homeCoordinate = CLLocationCoordinate2DMake(47.623935, -122.335812);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = MKCoordinateRegionMake(homeCoordinate, span);
    [self.mapView setRegion:region animated:true];
}
@end
