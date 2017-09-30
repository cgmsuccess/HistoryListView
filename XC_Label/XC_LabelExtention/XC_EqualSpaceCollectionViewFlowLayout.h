//
//  XC_EqualSpaceCollectionViewFlowLayout.h
//  zhutong
//
//  Created by apple on 17/9/29.
//  Copyright © 2017年 com.xc.zhutong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 每个选项靠左靠右还是居中

 - XC_collectionAlignTypeLeft:   左边
 - XC_collectionAlignTypeCenter: 右边
 - XC_collectionAlignTypeRight:  居中
 */
typedef NS_ENUM(NSInteger,XC_collectionAlignType) {
    XC_collectionAlignTypeLeft,
    XC_collectionAlignTypeCenter,
    XC_collectionAlignTypeRight
};

@interface XC_EqualSpaceCollectionViewFlowLayout : UICollectionViewFlowLayout

/** 这个属性是：每个cell 的对齐方式 ****/
@property (nonatomic)XC_collectionAlignType cellAligntype ;

/** 两个Cell之间的距离    */
@property (nonatomic,assign)CGFloat cellDistance;




@end
