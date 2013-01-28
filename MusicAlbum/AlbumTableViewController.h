//
//  AlbumTableViewController.h
//  MusicAlbum
//
//  Created by Charlie Chang on 1/27/13.
//
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewController : UITableViewController<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
