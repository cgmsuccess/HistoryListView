//
//  Demo2ViewController.m
//  HistoryListView
//
//  Created by apple on 17/9/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Demo2ViewController.h"
#import "XC_label.h"

@interface Demo2ViewController ()<selectHotOrHistoryDelegate>

@end

@implementation Demo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO ;
    self.view.backgroundColor = [UIColor yellowColor] ;
    
    NSArray *titleArr = @[@"哈哈",@"你好啊",@"什么",@"听说你很皮",@"铁头娃娃"];
    NSArray *historyArr = @[@"哈哈",@"你好啊",@"什么",@"听说你很皮",@"铁头娃娃"] ;
    
    XC_label *_xcLabel = [[XC_label alloc] initWithFrame:CGRectMake(0, 64, KmainScreenWidth, KmainScreenHeiht-64) AndTitleArr:titleArr AndhistoryArr:historyArr AndTitleFont:16 AndScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _xcLabel.delegate = self ; //实现了代理请务必实现代理方法
  
    
    _xcLabel.isShow_One = NO ; //第一组的编辑按钮是否显示 默认NO
    _xcLabel.isShow_Two = YES ;
    
    
    _xcLabel.opetionsColor = [UIColor redColor];  //修改选项的颜色。默认白色
    
    _xcLabel.headTitle_one = @"铁头娃";
//    _xcLabel.headTitle_two = @"没毛病";
    
    _xcLabel.section_heihtOne = 30 ; //第一组头高度
    _xcLabel.opetionsHeight = 40 ;
    
    
    [_xcLabel setOptionLoction:XC_collectionAlignTypeLeft]; //选项居左边
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
