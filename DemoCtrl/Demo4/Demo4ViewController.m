//
//  Demo4ViewController.m
//  HistoryListView
//
//  Created by apple on 17/9/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Demo4ViewController.h"
#import "Demo4Header.h"
#import "UIView+XC_Frame.h"
@interface Demo4ViewController ()

/** 这个属性是：****/
@property (nonatomic,weak)Demo4Header *demo4Header ;


@end

@implementation Demo4ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    self.automaticallyAdjustsScrollViewInsets = NO ;
    self.view.backgroundColor = [UIColor yellowColor] ;
    
    
    [self setHeader];
    
}

-(void)setHeader
{
    Demo4Header *HeaderView = [Demo4Header loadDemo4headerView];
    self.demo4Header = HeaderView ;
    [self.view addSubview:self.demo4Header];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.demo4Header.xc_y = 64 ;
    self.demo4Header.xc_width = KmainScreenWidth ;
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
