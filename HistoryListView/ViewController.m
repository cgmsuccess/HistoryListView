//
//  ViewController.m
//  HistoryListView
//
//  Created by apple on 17/7/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"

#import "XC_label.h"
#import "XC_ShearchBarView.h"

#define LabelScreenW [UIScreen mainScreen].bounds.size.width
#define LabelScreenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<selectHotOrHistoryDelegate,Xc_serchViewCilckBtn>

@property (nonatomic,strong) XC_label  *xcLabel ;

@property (nonatomic,strong)NSMutableArray *dataSource ;//推荐搜索

@property (nonatomic,strong)NSMutableArray *historySource ;//历史搜索

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUIsearch]; //设置SearchBar
    [self hotOptions] ;//推荐搜索
    
}

#pragma mark 这里是 设置搜索页面 的UI
-(void)setUIsearch
{
    XC_ShearchBarView *searchView = [[XC_ShearchBarView alloc] initWithFrame:CGRectMake(0, 0, LabelScreenW, 64)];
    searchView.delegate = self ;
    [self.view addSubview:searchView];
}

-(void)hotOptions
{
    //推荐搜索 ，模拟网络数据
    NSArray *arr = @[@"fes4ewrew",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷"];
    
    self.dataSource = [NSMutableArray arrayWithArray:arr];
    
    //历史搜索 。本地数据库里面拿数据
    NSArray *historyArr =@[@"蜂飞舞",@"粉丝纷纷",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷"];
    self.historySource = [NSMutableArray arrayWithArray:historyArr];
    
    _xcLabel = [[XC_label alloc] initWithFrame:CGRectMake(0, 64, LabelScreenW, LabelScreenH-64) AndTitleArr:arr AndhistoryArr:historyArr AndTitleFont:16];
    
    _xcLabel.delegate = self ;
    
    [self.view addSubview:_xcLabel];
}




#pragma mark selectHotOrHistoryDelegate
//选中某个选项
-(void)selectHotOrHistory:(NSString *)historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString *)selectTitle{
    [self.view endEditing:YES];
    NSLog(@"historyOrHot = %@ , index = %ld , selectTitle = %@" ,historyOrHot ,(long)index ,selectTitle);
    //这里是选中某个选项， 主要处理跳转逻辑
  
}

//删除历史选项
-(void)deleteHistoryOptions:(NSString *)historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString *)selectTitle
{
    [self.view endEditing:YES];
    
    NSLog(@"historyOrHot = %@ , index = %ld , selectTitle = %@" ,historyOrHot ,(long)index ,selectTitle);
    
    //这里可以删除本地数据 逻辑
}

#pragma mark Xc_serchViewCilckBtn
-(void)cilckCancle{
    [self.view endEditing:YES];
    
    NSLog(@"单击了取消");
}

-(void)searchresult:(NSString *)resultString{
    NSLog(@"搜索的关键字 = %@" ,resultString) ;
    //搜索了关键字 ，就需要历史记录添加进去
    [_xcLabel insertHistorOptions:resultString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
