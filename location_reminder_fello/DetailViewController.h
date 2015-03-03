//
//  DetailViewController.h
//  location_reminder_fello
//
//  Created by nacnud on 3/2/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface DetailViewController : UIViewController
@property (strong,nonatomic) MKPointAnnotation *selectedAnnotation;
@property (strong,nonatomic) CLLocationManager *locationManager;
@end
