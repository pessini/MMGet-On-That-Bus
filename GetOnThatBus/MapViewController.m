//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Leandro Pessini on 3/24/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "API.h"
#define CHICAGO_LATITUDE 41.8781136
#define CHICAGO_LONGTITUDE -87.6297982

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSMutableArray *mapPins;
@property API *main;
@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Delegate
    self.mapView.delegate = self;

    //Get data from model
    self.mapPins = [API stopsArray];

    //Add annotation to map for every item in our array
    for (API *annotation in self.mapPins) {
        [self.mapView addAnnotation:annotation];
    }

    //Show annotations on map
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
    [self gotoLocation];
}

#pragma mark - MapKit
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    API *newAnnotation = annotation;
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
    /**
     *  Set initial annotations to stop name and routes.
     */
    newAnnotation.title = newAnnotation.stopName;
    newAnnotation.subtitle = [NSString stringWithFormat:@"Routes: %@",newAnnotation.routes];

    /**
     *  If intermodal matches "Metra", change the pin image to green
     *  If intermodal matches "Pace", change pin to yellow
     */

    if ([newAnnotation.intermodal isEqualToString:@"Metra"])
    {
        pin.pinColor = MKPinAnnotationColorGreen;
    }
    else if ([newAnnotation.intermodal isEqualToString:@"Pace"])
    {
        pin.pinColor = MKPinAnnotationColorPurple;
    }
    else
    {
        pin.pinColor = MKPinAnnotationColorRed;
    }

    
     /*  Display pin with button desclosure
     */
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return pin;
}

/**
 *  Method that detects tap on accessory control. We override MKAnnotationView and pass our PointAnnotation, asing the selcted pin to
 *  Our PointAnnotation property. We then use performSegueWithIdentifier  and use MKPointAnnotation as the sender.
 *
 *  @param view    MKAnnotationView has a property of annotation. We pass that value to PointAnnotation
 *
 */

- (void)gotoLocation
{
    MKCoordinateRegion newRegion;

    newRegion.center.latitude = CHICAGO_LATITUDE;
    newRegion.center.longitude = CHICAGO_LONGTITUDE;

    newRegion.span.latitudeDelta = 0.2f;
    newRegion.span.longitudeDelta = 0.2f;

    [self.mapView setRegion:newRegion animated:YES];
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    API *selectedPin = view.annotation;
    self.main = selectedPin;
//    [self performSegueWithIdentifier:@"detailView" sender:selectedPin];
}

@end
