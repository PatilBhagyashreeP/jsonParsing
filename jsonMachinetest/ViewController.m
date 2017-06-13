//
//  ViewController.m
//  jsonMachinetest
//
//  Created by Student P_08 on 24/04/17.
//  Copyright © 2017 shree. All rights reserved.
//

#import "ViewController.h"
#import "customTableViewCell.h"
#import "secViewController.h"

@interface ViewController (){
    NSIndexPath *index;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self jsonParse];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)jsonParse{
    
    NSString *str=@"https://newsapi.org/v1/articles?source=espn-cric-info&sortBy=top&apiKey=efe99de73d1d49608eb3d4e87c536b26";
    [_activityIndicator startAnimating];

    NSURL *url=[NSURL URLWithString:str];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error!=nil) {
            UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Alert" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
            [controller addAction:action];
            [self presentViewController:controller animated:YES completion:nil];
            
        }
        else{
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            _arrArticles=[dict valueForKey:@"articles"];

            dispatch_async(dispatch_get_main_queue(), ^{
                if (_arrArticles.count) {
                    _tblView.delegate=self;
                    _tblView.dataSource=self;
                    [_tblView reloadData];
                    
                }

                
            });
            
        }
        [_activityIndicator stopAnimating];
        _activityIndicator.hidden=YES;
        
    }];
    [task resume];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrArticles.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    customTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[customTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.lblAuthor.text=[NSString stringWithFormat:@"%@" ,[[_arrArticles objectAtIndex:indexPath.row]valueForKey:@"author"]];
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[[_arrArticles objectAtIndex:indexPath.row]valueForKey:@"title"]];
    dispatch_queue_t thred=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(thred, ^{
        NSString *strImg=[NSString stringWithFormat:@"%@",[[_arrArticles objectAtIndex:indexPath.row]valueForKey:@"urlToImage"]];
        NSURL *url=[NSURL URLWithString:strImg];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img=[UIImage imageWithData:data];

        if (img) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imgView.layer.cornerRadius=cell.imgView.frame.size.height/2;
                cell.imgView.clipsToBounds=YES;
                cell.imgView.image=img;
                

            });
        }
    });
    
    

    
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    index=indexPath;
    [self performSegueWithIdentifier:@"pushTosecVC" sender:self];
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"pushTosecVC"]) {
        secViewController *obj=[segue destinationViewController];
        obj.str1=[NSString stringWithFormat:@"%@" ,[[_arrArticles objectAtIndex:index.row]valueForKey:@"author"]];
        obj.str2=[NSString stringWithFormat:@"%@",[[_arrArticles objectAtIndex:index.row]valueForKey:@"title"]];
        obj.str3=[NSString stringWithFormat:@"%@",[[_arrArticles objectAtIndex:index.row]valueForKey:@"urlToImage"]];
        obj.str4=[NSString stringWithFormat:@"%@",[[_arrArticles objectAtIndex:index.row]valueForKey:@"url"]];
    }
}
- (IBAction)segControlAct:(id)sender {
    UISegmentedControl *segControl=(UISegmentedControl *)sender;
    
    if (segControl.selectedSegmentIndex==0) {
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"author" ascending:YES];
        _arrArticles=[_arrArticles sortedArrayUsingDescriptors:@[sort]];
        [_tblView reloadData];
    }
    else{
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"author" ascending:NO];
        _arrArticles=[_arrArticles sortedArrayUsingDescriptors:@[sort]];
        [_tblView reloadData];


        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
