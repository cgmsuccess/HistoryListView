//
//  XC_ShearchBarView.m
//  zhutong
//
//  Created by apple on 17/7/1.
//  Copyright © 2017年 com.xc.zhutong. All rights reserved.
//

#import "XC_ShearchBarView.h"
#import "UIButton+CGMCilckBtn.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define LabelScreenW [UIScreen mainScreen].bounds.size.width
#define LabelScreenH [UIScreen mainScreen].bounds.size.height
@interface XC_ShearchBarView()<UISearchBarDelegate>

@property(nonatomic,strong)UISearchBar *searchBar;


@end

@implementation XC_ShearchBarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self customUI];
    }
    return self ;
}


-(void)customUI
{
    WS(weakSelf);
    self.backgroundColor = [UIColor whiteColor];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0,LabelScreenW,64)];
    self.searchBar.delegate = self;
    [self.searchBar setTintColor:[UIColor blackColor]];// 那个光标颜色
    [self.searchBar setTranslucent:YES];// 设置是否透明
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"]];// 设置背景图片
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forState:UIControlStateHighlighted];
    [self.searchBar setSearchFieldBackgroundPositionAdjustment:UIOffsetMake(0, 10)];// 设置搜索框中文本框的偏移量
    [self.searchBar setShowsCancelButton:YES];// 是否显示取消按钮
    [self.searchBar setShowsCancelButton:YES animated:YES];
    [self.searchBar setPlaceholder:@"请输入关键字"];// 搜索框的占位符
    
    //自定义右边的取消
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn sizeToFit];
    cancleBtn.center = CGPointMake(LabelScreenW - 28, 42);
    [cancleBtn setTitleColor:[UIColor colorWithRed:66/255.0 green:124/255.0 blue:145/255.0 alpha:1]
    forState:UIControlStateNormal];
    
    [cancleBtn CgmCilckBtn:UIControlEventTouchUpInside AndCGMCallCback:^(UIButton *btn) {

        if ([weakSelf.delegate respondsToSelector:@selector(cilckCancle)]) {
            [weakSelf.delegate cilckCancle];
        }
    }];
    
    //隐藏searchBar 的取消btn
    for (UIView *subview in self.searchBar.subviews) {
        for (UIView *view in subview.subviews) {
            NSLog(@"view = %@" ,view);
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btton = (UIButton *)view ;
                btton.hidden = YES;
            }
        }
    }
    [self addSubview:self.searchBar];
    [self addSubview:cancleBtn];
}


-(void)setSearchKeyWord:(NSString *)searchKeyWord{
    _searchKeyWord = searchKeyWord ;
    self.searchBar.text = searchKeyWord ;
}


#pragma mark UISearchBarDelegate

// 键盘中，搜索按钮被按下，执行的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
        NSLog(@"---%@",searchBar.text);
    if ([self.delegate respondsToSelector:@selector(searchresult:)]) {
        [self.delegate searchresult:searchBar.text];
    }
}



@end
