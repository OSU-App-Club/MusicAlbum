//
//  AlbumTableViewController.m
//  MusicAlbum
//
//  Created by Charlie Chang on 1/27/13.
//
//

#import "AlbumTableViewController.h"
#import "AlbumReviewDetailViewController.h"
#import <RestKit/RestKit.h>
#import "Label.h"
#import "Review.h"

@interface AlbumTableViewController ()

@end


@implementation AlbumTableViewController

@synthesize searchBar = _searchBar;
@synthesize reviews;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"reviews:%d", [reviews count]);
    return [reviews count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"reload");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[reviews objectAtIndex:indexPath.row] name];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    AlbumReviewDetailViewController *detailViewController = [[AlbumReviewDetailViewController alloc] init];
    
    [detailViewController setReview:[reviews objectAtIndex:indexPath.row]];
     [self.navigationController pushViewController:detailViewController animated:YES];

}


#pragma mark - TODO

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
//    Restkit
    RKDynamicMapping *mapping = [RKDynamicMapping new];
    
    RKObjectMapping *reviewLabelMapping = [RKObjectMapping mappingForClass:[Label class] ];
    [reviewLabelMapping addAttributeMappingsFromDictionary:@{
     @"label": @"label",
     }];

    
    RKObjectMapping *reviewMapping = [RKObjectMapping mappingForClass:[Review class]];
    [reviewMapping addAttributeMappingsFromDictionary:@{
     @"name": @"name",
     @"url" : @"url"
     }];
    
    RKRelationshipMapping *reviewRelationship = [RKRelationshipMapping relationshipMappingFromKeyPath:@"objects" toKeyPath:@"objects" withMapping:reviewMapping];
    
    [reviewLabelMapping addPropertyMapping:reviewRelationship];
    
    [mapping addMatcher:[RKObjectMappingMatcher matcherWithKeyPath:@"label" expectedValue:@"Reviews" objectMapping:reviewLabelMapping]];
        
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@\"%@\"", @"http://pitchfork.com/search/ac/?query=",searchBar.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
//    reviewMapping mapk
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx

    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:nil keyPath:nil statusCodes:statusCodes];


    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        Label *label = [result firstObject];
        reviews = label.objects;
        [self.tableView reloadData];
        [searchBar resignFirstResponder];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];
    
    [operation start];
   

}

- (void)viewDidUnload {
    [self setSearchBar:nil];
    [super viewDidUnload];
}
@end
