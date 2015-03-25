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

@property NSMutableArray *receivedItems;
@property NSString *address;
-(void)apiRequestFromURL:(void(^)(NSMutableArray *searchArray))completionHandler;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property MKPointAnnotation *annotation;
@property NSMutableArray *pinArray;
+ (NSMutableArray *)stopsArray;
@end
