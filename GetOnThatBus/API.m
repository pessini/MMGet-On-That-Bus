//
//  BusAPI.m
//  GetOnThatBus
//
//  Created by Leandro Pessini on 3/24/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "API.h"


@interface API()

@end

#define API_URL @"https://s3.amazonaws.com/mobile-makers-lib/bus.json"

@implementation API

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.address = dictionary[@"_address"];
        self.busID = dictionary[@"_id"];
        self.position = dictionary[@"_position"];
        self.uuid = dictionary[@"_uuid"];
        self.stopName = dictionary[@"cta_stop_name"];
        self.direction = dictionary[@"direction"];
        self.locationLat = dictionary[@"location"][@"latitude"];
        self.locationLong = dictionary[@"location"][@"longitude"];
        self.latitude = dictionary[@"latitude"];
        self.longitude = dictionary[@"longitude"];
        self.routes = dictionary[@"routes"];
        self.stopID = dictionary[@"stop_id"];
        self.ward = dictionary[@"ward"];
        self.intermodal = dictionary[@"inter_modal"];

        double latitude = [dictionary[@"latitude"] doubleValue];
        double longitude;

        if ([dictionary[@"longitude"] doubleValue] > 0) {
            longitude = -[dictionary[@"longitude"] doubleValue];
        }
        else {
            longitude = [dictionary[@"longitude"]doubleValue];
        }
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
    return self;
}

+ (NSMutableArray *)stopsArray {
    NSMutableArray *pinArray = [NSMutableArray new];
    NSString *searchString = API_URL;
    NSURL *url = [NSURL URLWithString:searchString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data)
    {
        NSDictionary *mapDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *mapArray = mapDict[@"row"];
        for (NSDictionary *stops in mapArray)
        {
            API *pins = [[API alloc] initWithDictionary:stops];
            [pinArray addObject:pins];
        }
    }
    return pinArray;
}

@end
