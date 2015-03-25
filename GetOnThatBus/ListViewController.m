//
//  ListViewController.m
//  GetOnThatBus
//
//  Created by Leandro Pessini on 3/24/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "ListViewController.h"
#import "API.h"
#import "DetailViewController.h"

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property API *busStops;
@property NSMutableArray *arrayWithData;

@end

@implementation ListViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // TableView Delegates
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.arrayWithData = [NSMutableArray new];
    self.arrayWithData = [API stopsArray];

    for (API *annotation in self.arrayWithData)
    {
        NSLog(@"%@", annotation.address);

//        [self.mapView addAnnotation:annotation];
    }


}

#pragma mark -UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayWithData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
//    NSDictionary *stops = [self.arrayWithData objectAtIndex:indexPath.row];
    cell.textLabel.text  = [NSString stringWithFormat:@"Count: %lu", (unsigned long)self.arrayWithData.count];
//    cell.detailTextLabel.text = [stops objectForKey:@"direction"];
    return cell;
}

#pragma mark -Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell
{
    if ([segue.identifier isEqualToString:@"ShowDetailSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        UINavigationController *navigationController = segue.destinationViewController;
        DetailViewController *detailViewController = navigationController.viewControllers[0];

        NSDictionary *stops = [self.arrayWithData objectAtIndex:indexPath.row];
        detailViewController.title =  [stops objectForKey:@"cta_stop_name"];
        detailViewController.name =  [stops objectForKey:@"cta_stop_name"];
    }
}

@end
