//
//  InterfaceController.m
//  location_reminder_fello WatchKit Extension
//
//  Created by nacnud on 3/2/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "InterfaceController.h"
#import <CoreLocation/CoreLocation.h>
#import "RegionTableRowController.h"


@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceTable *tabel;
@property (strong,nonatomic) NSArray *regionsArray;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    CLLocationManager *locationManager = [CLLocationManager new];
    NSSet *regions = locationManager.monitoredRegions;
    self.regionsArray = regions.allObjects;
    
    
    
    [self.tabel setNumberOfRows:regions.count withRowType:@"REGION_ROW"];
    NSInteger index = 0;
    for (CLRegion *region in _regionsArray) {
        RegionTableRowController *rowController = [self.tabel rowControllerAtIndex:index];
        [rowController.label setText:region.identifier];
        index++;
    }
}


-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex {
    return (CLCircularRegion *) self.regionsArray[rowIndex];
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



