//
//  DetailViewController.m
//  location_reminder_fello
//
//  Created by nacnud on 3/2/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextField *textFeild;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textFeild.delegate = self;
    self.textFeild.text = nil;
    self.textFeild.placeholder = @"Reminder";
    
    
    NSString *latitudeStr = [NSString stringWithFormat:@"%f", self.selectedAnnotation.coordinate.latitude];
    NSString *longitudeStr = [NSString stringWithFormat:@"%f", self.selectedAnnotation.coordinate.longitude];
    self.locationLabel.text = [NSString stringWithFormat:@"Set Remider for location with latitude %@ and longitude %@", latitudeStr,longitudeStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textFeild resignFirstResponder];
    return true;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)pressedDone:(id)sender {
    NSLog(@"Pressed DoneButton: withTextfieldContents %@", self.textFeild.text);
    
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class ]]){
        CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:self.selectedAnnotation.coordinate radius:100 identifier:self.textFeild.text];
        [self.locationManager startMonitoringForRegion:region];
        NSDictionary *regionInfo = @{@"region" :region};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderRegionAdded" object:self userInfo:regionInfo];
    }
    
    [self.navigationController popToRootViewControllerAnimated:true];

}

@end
