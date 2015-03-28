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

    self.navigationItem.title = @"Bus Stops List";
}

#pragma mark -UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayWithData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    API *annotation = [self.arrayWithData objectAtIndex:indexPath.row];

    /**
     *  Updtate cell image and title text color depending on intermodal text.
     */
    if ([annotation.intermodal isEqualToString:@"Metra"])
    {
        cell.textLabel.textColor = [UIColor colorWithRed:0.12 green:0.56 blue:0.39 alpha:1.00];

    }
    else if ([annotation.intermodal isEqualToString:@"Pace"])
    {
        cell.textLabel.textColor = [UIColor colorWithRed:0.83 green:0.43 blue:0.86 alpha:1.00];
    }
    else
    {
        cell.textLabel.textColor = [UIColor colorWithRed:0.90 green:0.00 blue:0.05 alpha:1.00];
    }

    cell.textLabel.text = annotation.stopName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Available Routes: %@", annotation.routes];

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
