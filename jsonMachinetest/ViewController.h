//
//  ViewController.h
//  jsonMachinetest
//
//  Created by Student P_08 on 24/04/17.
//  Copyright © 2017 shree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tblView;
- (IBAction)segControlAct:(id)sender;
@property (strong,nonatomic) NSArray *arrArticles;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

