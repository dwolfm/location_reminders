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
#import "DetailViewController.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) MKPointAnnotation *selectedAnnotation;
@property (strong,nonatomic) NSMutableArray *regions;
@property (strong,nonatomic) UILongPressGestureRecognizer *longPress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set up mapview
    self.mapView.delegate = self;
    self.mapView.rotateEnabled = false;
    
    //set up location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // setup gesture recogniser and add to mapview
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress:)];
    [self.mapView addGestureRecognizer:self.longPress];
    
    //initializer the notification center listener
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reminderAdded:) name:@"ReminderRegionAdded" object:nil];
    
    
    
    /// must add NSLocationAlwaysUsageDescription key in Info.plist
    if ([CLLocationManager locationServicesEnabled]) {
        NSInteger authNum = [CLLocationManager authorizationStatus];
        
        switch (authNum) {
            case 0: {
                NSLog(@"locationmanager auth status hit status0 status not yet determined");
                [self.locationManager requestAlwaysAuthorization];
                break;
            }
            case 1: {
                NSLog(@"locationmanager auth status hit status 1 in authswitch");
                break;
            }
            case 2: {
                NSLog(@"locationmanager auth status hit case 2 in authswitch access denied");
                break;
            }
            case 3:{
                NSLog(@"locationmanager auth status hit case 3 access granted");
                self.mapView.showsUserLocation = true;
                [self.locationManager startUpdatingLocation];
                break;
            }
            case 4:{
                NSLog(@"locationmanager auth status hit case 4 location is allways authorized");
                self.mapView.showsUserLocation = true;
                [self.locationManager startUpdatingLocation];
                break;
            }
            default:
                NSLog(@"locationmanager auth status hit dfault OH NO THIS IS BAD!");
                break;
        }
    } else {
        NSLog(@"location services are not enable, show alertView");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"plese enable your location services in the Settings App"
    delegate:self cancelButtonTitle:@"ok, ima do that right now!" otherButtonTitles:nil , nil];
        [alert show];
    }
    
    
    
}

-(void)reminderAdded:(NSNotification * ) notification {
    NSDictionary* reminderRegion = notification.userInfo;
    CLCircularRegion *region = reminderRegion[@"region"];
    MKCircle *regionOverlay = [MKCircle circleWithCenterCoordinate:region.center radius:region.radius];
    [self.mapView addOverlay:regionOverlay];
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKCircleRenderer* renderer = [[MKCircleRenderer alloc] initWithCircle:overlay];
    renderer.alpha = 0.35;
    renderer.fillColor = [UIColor colorWithRed:1 green:0   blue:0.0 alpha:0.6];
    renderer.strokeColor = [UIColor brownColor];
    return renderer;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"the num o reginons in the location Manager is %lu", self.locationManager.monitoredRegions.count);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recr∑eated.
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    // add an alert to notify users that location services are unavailable
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Location Servaces are failing" delegate:self cancelButtonTitle:@"Exit" otherButtonTitles:nil , nil];
    [alert show];
    NSLog(@"Location services are failing.");
}



-(void) didLongPress:(id)sender {
    UILongPressGestureRecognizer *press = (UILongPressGestureRecognizer *) sender;
    
    if (press.state == 3) {
        NSLog(@"yo madude! uu fersher just let go of a long press");
        CGPoint location = [press locationInView:self.view];
        CLLocationCoordinate2D mapCoordinates = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = mapCoordinates;
        annotation.title = @"Reminder Location";
        
        [self.mapView addAnnotation:annotation];
    }
}

//Mark: setup custon Annotation
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isEqual:[mapView userLocation]]){
        return nil;
    }
    
    MKPinAnnotationView *customAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    customAnnotation.animatesDrop = true;
    customAnnotation.pinColor = MKPinAnnotationColorGreen;
    customAnnotation.canShowCallout = true;
    customAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    return customAnnotation;
}

//Mark: did press anotation Accessory
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    self.selectedAnnotation = view.annotation;
    [self performSegueWithIdentifier:@"SHOW_DETAIL" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SHOW_DETAIL"] ){
        DetailViewController *detailVC = (DetailViewController *) segue.destinationViewController;
        detailVC.selectedAnnotation = self.selectedAnnotation;
        detailVC.locationManager = self.locationManager;
    }
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
