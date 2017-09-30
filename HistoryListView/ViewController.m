//
//  ViewController.m
//  HistoryListView
//
//  Created by apple on 17/7/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "Demo1ViewController.h"



static NSString *const cellID = @"cellID" ;

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tablewView;


@property (nonatomic,strong)NSArray *dataSource ;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self setUIsearch]; //设置SearchBar
//    [self hotOptions] ;//推荐搜索
    
    [self  setData];

    [self setUI];
    
    
}

-(void)setData
{
    self.dataSource = @[@"默认UI模拟推荐选项和历史搜索选项Demo1",
                        @"局部修改选项的UI和高度等Demo2",
                        @"把他作为一个键盘的toolsView使用Demo3"
                        ];
}

-(void)setUI
{
    self.automaticallyAdjustsScrollViewInsets = NO ;
    [self.tablewView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}



#pragma mark UITableViewDataSource,UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    NSString *title = self.dataSource[indexPath.row];
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.dataSource[indexPath.row];
    NSLog(@"title = %@" ,title );
    NSRange range = [title rangeOfString:@"Demo"];
    NSString *subTitle = [title substringToIndex:range.location];
    NSString *subTitle1 = [title substringFromIndex:range.location];
    NSLog(@"subTitle = %@ subTitle1 = %@ ",subTitle ,subTitle1 );
    NSString *ctrlTitle = [NSString stringWithFormat:@"%@ViewController",subTitle1];
    UIViewController *vc = [NSClassFromString(ctrlTitle) new];
    vc.title = subTitle1 ;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
