//
//  AlbumReviewDetailViewController.m
//  MusicAlbum
//
//  Created by Charlie Chang on 2/4/13.
//
//

#import "AlbumReviewDetailViewController.h"

@interface AlbumReviewDetailViewController ()

@end

@implementation AlbumReviewDetailViewController
@synthesize webView;
@synthesize review;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void) loadView
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    webView = [[UIWebView alloc]initWithFrame:frame];
    [webView setScalesPageToFit:YES];
    [self setView:webView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"http://pitchfork.com", [review url]]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {

    [super viewDidUnload];
}
@end
