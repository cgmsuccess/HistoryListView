//
//  Demo5ViewController.m
//  HistoryListView
//
//  Created by apple on 17/9/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Demo5ViewController.h"
#import "XC_label.h"

@interface Demo5ViewController ()<selectHotOrHistoryDelegate>
{
    XC_label *_xcLabel ;
}

@property (nonatomic,strong)NSMutableArray *dataSource ;//推荐搜索

@property (nonatomic,strong)NSMutableArray *historySource ;//历史搜索

@end

@implementation Demo5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    NSArray *arr = @[@"fes4发发ewrew",@"发顺丰",@"飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺发丰",@"蜂飞舞",@"粉丝发发发发发纷",@"fes",@"发发发顺丰",@"蜂发飞舞",@"粉发发发丝发纷纷",@"发发fes",@"发顺丰",@"蜂飞发舞",@"发",@"粉丝粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷"];

    self.dataSource = [NSMutableArray arrayWithArray:arr];
    self.historySource = [NSMutableArray array];
    
    _xcLabel = [[XC_label alloc] initWithFrame:CGRectMake(0, 64, KmainScreenWidth, KmainScreenHeiht - 64) AndTitleArr:self.dataSource AndhistoryArr:self.historySource AndTitleFont:16 AndScrollDirection:UICollectionViewScrollDirectionVertical];
    _xcLabel.delegate = self ;
    
    //    _xcLabel.isShow_One = YES ;  //默认NO 显示
    //    _xcLabel.isShow_Two = YES ; //默认NO 显示
    _xcLabel.headTitle_one = @"推荐的数据";
    
    [self.view addSubview:_xcLabel];
    
    
    
}

#pragma mark selectHotOrHistoryDelegate

-(void)selectHotOrHistory:(NSString *)historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString *)selectTitle
{
    [self.view endEditing:YES];
    XCLog(@"historyOrHot = %@ , index = %ld , selectTitle = %@" ,historyOrHot ,(long)index ,selectTitle);
}


-(void)deleteHistoryOptions:(NSString *)historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString *)selectTitle AndNSdataSource:(NSMutableArray *)dataSource
{
    XCLog(@"historyOrHot = %@ , index = %ld , selectTitle = %@" ,historyOrHot ,(long)index ,selectTitle);
}


-(void)deleteHotOptions:(NSString *)historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString *)selectTitle AndNSdataSource:(NSMutableArray *)dataSource
{
    XCLog(@"historyOrHot = %@ , index = %ld , selectTitle = %@" ,historyOrHot ,(long)index ,selectTitle);
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
