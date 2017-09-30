//
//  XC_labelCollectionViewCell.h
//  zhutong
//
//  Created by apple on 17/6/30.
//  Copyright © 2017年 com.xc.zhutong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Label_btn.h"

@interface XC_labelCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *xc_label;

@property (weak, nonatomic) IBOutlet Label_btn *closeBtnOutle;

@property (weak, nonatomic) IBOutlet UIView *cellBackView;

/** 这个属性是：背景颜色****/
@property (nonatomic)UIColor * cellbackColor;


@end
