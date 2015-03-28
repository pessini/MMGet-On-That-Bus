//
//  BusAPI.h
//  GetOnThatBus
//
//  Created by Leandro Pessini on 3/24/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface API : MKPointAnnotation

@property NSString *address;
@property NSString *busID;
@property NSString *position;
@property NSString *uuid;
@property NSString *stopName;
@property NSString *latitude;
@property NSString *longitude;
@property NSString *locationLat;
@property NSString *locationLong;
@property NSString *routes;
@property NSString *ward;
@property NSString *completeLocation;
@property MKPointAnnotation *annotation;
@property NSMutableArray *pinArray;

@property NSString *stopID;
@property NSString *direction;
@property NSString *intermodal;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)stopsArray;
@end
