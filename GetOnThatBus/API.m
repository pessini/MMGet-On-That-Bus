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

NSString * const API_URL = @"https://s3.amazonaws.com/mobile-makers-lib/bus.json";

@implementation API

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.address = dictionary[@"_address"];
    }
    return self;
}

+ (NSMutableArray *)stopsArray {
    NSMutableArray *pinArray = [NSMutableArray new];
    NSString *searchString = [NSString stringWithFormat:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    NSURL *url = [NSURL URLWithString:searchString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *mapDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *mapArray = mapDict[@"row"];
    for (NSDictionary *stops in mapArray) {
        API *annotations = [[API alloc] initWithDictionary:stops];
        annotations.title = annotations.address;
        annotations.subtitle = annotations.address;
        [pinArray addObject:annotations];

        NSLog(@"%@", annotations.address);

    }
    return pinArray;
}


-(void)apiRequestFromURL:(void (^)(NSMutableArray *searchArray))completionHandler
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", API_URL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&connectionError];

        NSArray *itemArray = dictionary[@"row"];
        NSMutableArray *results = [NSMutableArray new];

        for (NSDictionary *items in itemArray)
        {
            API *model = [[API alloc] initWithDictionary:items];
            [results addObject:model];
//            NSLog(@"API: %@", model.address);
        }

        completionHandler(results);

//        [self.eventsTableView reloadData];
    }];
}


@end
