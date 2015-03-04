//
//  MiniMapInterfaceController.m
//  location_reminder_fello
//
//  Created by nacnud on 3/4/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "MiniMapInterfaceController.h"


@interface MiniMapInterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceMap *map;

@end


@implementation MiniMapInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.circularRegion = context;
    NSLog(@"%@", self.circularRegion.identifier);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(self.circularRegion.center, MKCoordinateSpanMake(0.001, 0.001));
    [self.map setRegion:region];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



