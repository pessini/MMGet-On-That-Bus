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
#import "DetailViewController.h"

#define CHICAGO_LATITUDE 41.8781136
#define CHICAGO_LONGTITUDE -87.6297982

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSMutableArray *mapPins;
@property API *selectedStop;
@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Delegate
    self.mapView.delegate = self;

    //Get data from model
    self.mapPins = [API stopsArray];
    [self allPins];
    [self gotoLocation];
}

#pragma mark - MapKit

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    API *newAnnotation = annotation;
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
    newAnnotation.title = newAnnotation.stopName;
    newAnnotation.subtitle = [NSString stringWithFormat:@"Routes: %@",newAnnotation.routes];
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
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return pin;
}

#pragma mark - Pins

-(void)allPins
{
    //Add annotation to map for every item in our array
    for (API *annotation in self.mapPins)
    {
        [self.mapView addAnnotation:annotation];
    }

    //Show annotations on map
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}

#pragma mark - Map Zoom

- (void)gotoLocation
{
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = CHICAGO_LATITUDE;
    newRegion.center.longitude = CHICAGO_LONGTITUDE;
    newRegion.span.latitudeDelta = 0.2f;
    newRegion.span.longitudeDelta = 0.2f;
    [self.mapView setRegion:newRegion animated:YES];
}

#pragma mark - Action

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    API *selectedPin = view.annotation;
    self.selectedStop = selectedPin;
    [self performSegueWithIdentifier:@"ShowDetailSegue" sender:selectedPin];
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDetailSegue"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        DetailViewController *detailViewController = navigationController.viewControllers[0];
        detailViewController.title = self.selectedStop.stopName;
        detailViewController.busStop = self.selectedStop;
    }
}

@end
