//
//  Demo1ViewController.m
//  HistoryListView
//
//  Created by apple on 17/9/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Demo1ViewController.h"

#import "XC_label.h"
#import "XC_ShearchBarView.h"

#define LabelScreenW [UIScreen mainScreen].bounds.size.width
#define LabelScreenH [UIScreen mainScreen].bounds.size.height

@interface Demo1ViewController ()<selectHotOrHistoryDelegate,Xc_serchViewCilckBtn>

@property (nonatomic,strong) XC_label  *xcLabel ;

@property (nonatomic,strong)NSMutableArray *dataSource ;//推荐搜索

@property (nonatomic,strong)NSMutableArray *historySource ;//历史搜索

@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES ;
    
    [self setUIsearch];
    
    [self hotOptions];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO  ;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = YES  ;
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
    NSArray *arr = @[@"fes4发发ewrew",@"发顺丰",@"飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺发丰",@"蜂飞舞",@"粉丝发发发发发纷",@"fes",@"发发发顺丰",@"蜂发飞舞",@"粉发发发丝发纷纷",@"发发fes",@"发顺丰",@"蜂飞发舞",@"发",@"粉丝粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷"];

    self.dataSource = [NSMutableArray arrayWithArray:arr];
    //历史搜索 。模拟本地数据库里面拿数据
    NSArray *historyArr =@[@"蜂飞舞",@"粉丝纷纷",@"发顺丰",@"发顺丰",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞"];
    self.historySource = [NSMutableArray arrayWithArray:historyArr];

    _xcLabel = [[XC_label alloc] initWithFrame:CGRectMake(0, 64, LabelScreenW, LabelScreenH-64) AndTitleArr:arr AndhistoryArr:historyArr AndTitleFont:16 AndScrollDirection:UICollectionViewScrollDirectionVertical];
    _xcLabel.delegate = self ;
    
//    _xcLabel.isShow_One = YES ;  //默认NO 显示
//    _xcLabel.isShow_Two = YES ; //默认NO 显示
    
    [self.view addSubview:_xcLabel];
}

#pragma mark selectHotOrHistoryDelegate
//选中某个选项
-(void)selectHotOrHistory:(NSString *)historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString *)selectTitle{
    [self.view endEditing:YES];
    XCLog(@"historyOrHot = %@ , index = %ld , selectTitle = %@" ,historyOrHot ,(long)index ,selectTitle);
    //这里是选中某个选项， 主要处理跳转逻辑
}

//删除历史选项
-(void)deleteHistoryOptions:(NSString *)historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString * _Nullable)selectTitle AndNSdataSource:(NSMutableArray * _Nullable)dataSource{
    [self.view endEditing:YES];

    XCLog(@"historyOrHot = %@ , index = %ld , selectTitle = %@ , dataSource = %@" ,historyOrHot ,(long)index ,selectTitle,dataSource);

    //这里可以删除本地数据 逻辑 UI 已经处理好了。只需要删除暴露在外面对应的数据源就可以了
    
}

//删除热搜选项
-(void)deleteHotOptions:(NSString * _Nullable)historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString * _Nullable)selectTitle AndNSdataSource:(NSMutableArray *_Nullable)dataSource
{
    XCLog(@"historyOrHot = %@ , index = %ld , selectTitle = %@ , dataSource = %@" ,historyOrHot ,(long)index ,selectTitle,dataSource);
    //这里可以删除热搜数据 逻辑 UI 已经处理好了。只需要删除暴露在外面对应的数据源就可以了


}

#pragma mark Xc_serchViewCilckBtn
-(void)cilckCancle{
    [self.view endEditing:YES];
    XCLog(@"单击了取消");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchresult:(NSString *)resultString{
    XCLog(@"搜索的关键字 = %@" ,resultString) ;
    [self.view endEditing:YES];

    
    //1 ,这里做去重复逻辑
    
    //2 ,去重复逻辑之后直接丢字符串进去，已经处理好了
    
    //搜索了关键字 ，就需要历史记录添加进去
    [_xcLabel insertHistorOptions:resultString];
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
