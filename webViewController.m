//
//  webViewController.m
//  jsonMachinetest
//
//  Created by Student P_08 on 24/04/17.
//  Copyright © 2017 shree. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()

@end

@implementation webViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,20 , self.view.frame.size.height, self.view.frame.size.width)];
    webView.backgroundColor=[UIColor grayColor];
    NSURL *url=[NSURL URLWithString:_strurl];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    webView.delegate=self;
    
    
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

@end
