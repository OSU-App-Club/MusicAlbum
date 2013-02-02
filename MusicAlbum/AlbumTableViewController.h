//
//  AlbumTableViewController.h
//  MusicAlbum
//
//  Created by Charlie Chang on 1/27/13.
//
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewController : UITableViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *reviews;
@end
