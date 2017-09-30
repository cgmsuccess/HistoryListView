//
//  Demo3ViewController.m
//  HistoryListView
//
//  Created by apple on 17/9/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Demo3ViewController.h"
#import "XC_label.h"
#import "UIView+XC_Frame.h"
#import "Demo3Header.h"
@interface Demo3ViewController ()<selectHotOrHistoryDelegate>


/** 这个属性是：头部 ****/
@property (nonatomic,weak)Demo3Header *demo3Header ;


@end

@implementation Demo3ViewController

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
    Demo3Header *HeaderView = [Demo3Header loadDemo3headerView];
    self.demo3Header = HeaderView ;
    [self.view addSubview:self.demo3Header];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.demo3Header.xc_y = 64 ;
    self.demo3Header.xc_width = KmainScreenWidth ;
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
