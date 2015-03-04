//
//  MiniMapInterfaceController.h
//  location_reminder_fello
//
//  Created by nacnud on 3/4/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "InterfaceController.h"
#import <MapKit/MapKit.h>

@interface MiniMapInterfaceController : WKInterfaceController
@property (strong,nonatomic) CLCircularRegion *circularRegion;
@end
