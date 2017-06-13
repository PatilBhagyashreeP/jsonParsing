//
//  secViewController.m
//  jsonMachinetest
//
//  Created by Student P_08 on 24/04/17.
//  Copyright © 2017 shree. All rights reserved.
//

#import "secViewController.h"
#import "webViewController.h"

@interface secViewController ()

@end

@implementation secViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lblAuthor2.text=_str1;
    _lblTitle2.text=_str2;
    NSURL *url=[NSURL URLWithString:_str3];
    NSData *data=[NSData dataWithContentsOfURL:url];
    UIImage *image=[UIImage imageWithData:data];
    _imgView.layer.cornerRadius=_imgView.frame.size.height/2;
    _imgView.clipsToBounds=YES;

    _imgView.image=image;
    [_btnWebView setTitle:_str4 forState:UIControlStateNormal];
    
    
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnAct:(id)sender {
    [self performSegueWithIdentifier:@"webViewsegue" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"webViewsegue"]) {
        webViewController *webView=[segue destinationViewController];
        webView.strurl=_str4;
        
    }
    
}
@end
