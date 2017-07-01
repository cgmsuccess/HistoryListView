//
//  UIButton+CGMCilckBtn.h
//  zhutong
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 com.xc.zhutong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <objc/runtime.h>

typedef void (^CGMcilckCallBack)(UIButton *btn);

@interface UIButton (CGMCilckBtn)


-(void)CgmCilckBtn:(UIControlEvents )Everns AndCGMCallCback:(CGMcilckCallBack )CGMCallBack;

@end
