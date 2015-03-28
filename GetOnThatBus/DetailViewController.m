//
//  DetailViewController.m
//  GetOnThatBus
//
//  Created by Leandro Pessini on 3/24/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *busStopImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *routesLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UILabel *intermodalLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleIntermodalLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadInfos];
}

#pragma mark - Helper Methods

- (void)loadInfos
{
    self.routesLabel.text = self.busStop.routes;
    self.directionLabel.text = self.busStop.direction;
    self.intermodalLabel.text = self.busStop.intermodal;
    [self setAddressFromLatidudeAndLongitude];

    if ([self.busStop.intermodal isEqualToString:@"Metra"])
    {
        self.busStopImageView.image = [UIImage imageNamed:@"bus-stop-green"];
    }
    else if ([self.busStop.intermodal isEqualToString:@"Pace"])
    {
        self.busStopImageView.image = [UIImage imageNamed:@"bus-stop-purple"];
    }
    else
    {
        self.busStopImageView.image = [UIImage imageNamed:@"bus-stop-red"];
        self.titleIntermodalLabel.hidden = YES;
        self.intermodalLabel.hidden = YES;
    }
}

- (void)setAddressFromLatidudeAndLongitude
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.busStop.coordinate.latitude longitude:self.busStop.coordinate.longitude];
    CLGeocoder *geoCoder = [CLGeocoder new];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
    {
        CLPlacemark *placemark = [placemarks firstObject];
        NSString *address = [NSString stringWithFormat:@"%@ %@ %@ %@",
                             placemark.thoroughfare,
                             placemark.locality,
                             placemark.administrativeArea,
                             placemark.postalCode];
        self.addressLabel.text = address;
    }];
}


@end
