//
//  XC_label.h
//  zhutong
//
//  Created by apple on 17/6/30.
//  Copyright © 2017年 com.xc.zhutong. All rights reserved.


#import <UIKit/UIKit.h>

@protocol selectHotOrHistoryDelegate <NSObject>

//__nullable表示对象可以是NULL或nil，而__nonnull表示对象不应该为空

/**
 选中某个选项

 @param historyOrHot 是 历史搜索 还是 推荐新闻
 @param index        选中的角标
 @param selectTitle  选中的title
 */
-(void)selectHotOrHistory:( NSString * _Nullable )historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString * _Nullable)selectTitle ;


/**
 删除历史记录某个选项

 @param historyOrHot 是 历史搜索 
 @param index         选中的角标
 @param selectTitle   选中的角标
 */
-(void)deleteHistoryOptions:(NSString * _Nullable)historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString * _Nullable)selectTitle ;


@end

@interface XC_label : UIView

-(instancetype _Nullable)initWithFrame:(CGRect)frame AndTitleArr:(NSArray *_Nullable)titleArr AndhistoryArr:(NSArray * _Nullable)historyArr AndTitleFont:(NSInteger)font;

@property (nonatomic, assign) id <selectHotOrHistoryDelegate> _Nonnull delegate;

/**
 插入某个历史记录选项

 @param options 搜索的字符串
 */
-(void)insertHistorOptions:(NSString * _Nullable)options;

@end
