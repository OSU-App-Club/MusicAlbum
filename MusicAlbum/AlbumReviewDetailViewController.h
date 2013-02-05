//
//  AlbumReviewDetailViewController.h
//  MusicAlbum
//
//  Created by Charlie Chang on 2/4/13.
//
//

#import <UIKit/UIKit.h>
#import "Review.h"

@interface AlbumReviewDetailViewController : UIViewController

@property (nonatomic, retain) Review *review;
@property (readonly, nonatomic) UIWebView *webView;

@end
