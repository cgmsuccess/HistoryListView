//
//  XC_label.h
//  zhutong
//
//  Created by apple on 17/6/30.
//  Copyright © 2017年 com.xc.zhutong. All rights reserved.


#import <UIKit/UIKit.h>
#import "XC_EqualSpaceCollectionViewFlowLayout.h"


@protocol selectHotOrHistoryDelegate <NSObject>

//__nullable表示对象可以是NULL或nil，而__nonnull表示对象不应该为空

@required
/**
 选中某个选项

 @param historyOrHot 是 历史搜索 还是 推荐新闻
 @param index        选中的角标
 @param selectTitle  选中的title
 */
-(void)selectHotOrHistory:( NSString * _Nullable )historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString * _Nullable)selectTitle ;


//要删除功能这个就是必须实现的
@optional
/**
 删除历史记录某个选项

 @param historyOrHot 是 历史搜索 
 @param index         选中的角标
 @param selectTitle   选中的角标
 */
-(void)deleteHistoryOptions:(NSString * _Nullable)historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString * _Nullable)selectTitle AndNSdataSource:(NSMutableArray *_Nullable)dataSource;;


/**
 删除推荐热搜的某个选项

 @param historyOrHot 热门推荐搜索
 @param index        选择的角标
 @param selectTitle  选择的选项的title
 */
-(void)deleteHotOptions:(NSString * _Nullable)historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString * _Nullable)selectTitle AndNSdataSource:(NSMutableArray *_Nullable)dataSource;



@end

@interface XC_label : UIView

/**
 实例化xcLabel

 @param frame      CGszie
 @param titleArr   第一组的数据
 @param historyArr 第二组的数据
 @param font       选项的字体大小·
 @param xcLabel_scrollDirection 上下滑动还是左右滑动
 @return xcLabel 
 */
-(instancetype _Nullable)initWithFrame:(CGRect)frame AndTitleArr:(NSArray *_Nullable)titleArr AndhistoryArr:(NSArray * _Nullable)historyArr AndTitleFont:(NSInteger)font AndScrollDirection:(UICollectionViewScrollDirection)xcLabel_scrollDirection;

@property (nonatomic, assign) id <selectHotOrHistoryDelegate> _Nonnull delegate;




/** 这个属性是：第一组的标题  默认显示推荐搜索 ****/
@property (nonatomic,copy,nullable)NSString *  headTitle_one ;
/** 这个属性是：第二组的标题  默认显示历史记录****/
@property (nonatomic,copy,nullable)NSString *  headTitle_two ;

/** 这个属性是：第一组的标题 的编辑 是否显示  默认显示isShow_One = NO ****/
@property (nonatomic,assign)BOOL isShow_One ;
/** 这个属性是：第二组的标题 的编辑 是否显示 默认显示 isShow_Two = NO ****/
@property (nonatomic,assign)BOOL isShow_Two ;




/*
 UICollectionViewScrollDirectionHorizontal
 UICollectionViewScrollDirectionVertical
 下面这4个属性 要注意这2个枚举的值
 注意这2个枚举， 如果水平和垂直滑动。那么设置组头 宽度 和 高度 才有对应的效果
 */

/** 这个属性是：第一组的标题 标题的高度 默认 40 ****/
@property (nonatomic,assign)CGFloat section_heihtOne ;
/** 这个属性是：第二组的标题  是否显示 默认 40 ****/
@property (nonatomic,assign)CGFloat section_heihtTwo ;

/** 这个属性是：第一组的标题 标题的宽段为屏幕宽度  ****/
@property (nonatomic,assign)CGFloat section_widthOne ;
/** 这个属性是：第二组的标题 的宽度 为屏幕宽度  ****/
@property (nonatomic,assign)CGFloat section_widthTwo ;




/** 这个属性是：每个选项的高度 ****/
@property (nonatomic,assign)CGFloat opetionsHeight ;
/** 这个属性是：每个选项的 颜色 color ****/
@property (nonatomic)UIColor * _Nullable opetionsColor ;


/**  设置是否显示 collectionview 的水平条  默认显示 */
-(void)setShowsHorizontalScrollIndicator:(BOOL)isShow;
/**  设置是否显示 collectionview 的垂直条  默认显示 */
-(void)setShowsVerticalScrollIndicator:(BOOL)isShow;
/**  每个选项时靠左边还是右边还是居中显示   */
-(void)setOptionLoction:(XC_collectionAlignType)alignType ;

/**  设置偏移量   */
-(void)setcolletionOffset:(CGPoint)offset AndAnimal:(BOOL)animal ;


/**
 插入某个历史记录选项

 @param options 搜索的字符串
 */
-(void)insertHistorOptions:(NSString * _Nullable)options;

/**
 刷新推荐的选项

 @param hotOptions 传入推荐的选项，数组，要是字符串
 */
-(void)reloadHotOptions:(NSMutableArray * _Nullable)hotOptions;

/**
 刷新推荐的历史选项

 @param historyOptions 传入历史的选项，数组，要是字符串
 */
-(void)reloadHistoryOptions:(NSMutableArray * _Nullable)historyOptions;

/**
 删除最后一个历史记录的选项
 */
-(void)deleteHistoryLastOptions;


@end
