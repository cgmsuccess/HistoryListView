//
//  XC_ShearchBarView.h
//  zhutong
//
//  Created by apple on 17/7/1.
//  Copyright © 2017年 com.xc.zhutong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Xc_serchViewCilckBtn <NSObject>

/**
 点击取消
 */
-(void)cilckCancle;


/**
 搜索结果
 
 */
-(void)searchresult:(NSString *_Nullable)resultString ;

@end


@interface XC_ShearchBarView : UIView


-(instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, assign) id <Xc_serchViewCilckBtn> _Nonnull delegate;

@property (nonatomic,copy)NSString * _Nonnull searchKeyWord ;//默认搜索的字

@end
