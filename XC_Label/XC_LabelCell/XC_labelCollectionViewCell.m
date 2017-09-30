//
//  XC_labelCollectionViewCell.m
//  zhutong
//
//  Created by apple on 17/6/30.
//  Copyright © 2017年 com.xc.zhutong. All rights reserved.
//

#import "XC_labelCollectionViewCell.h"

@implementation XC_labelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //这里为什么要在上面设置边框，但是颜色清空，为什么不一起在 drawRect 画边框。 。因为我用drawRect 描边，但是曲线哪里很粗糙，一时不知道声明原因，故用了这个办法
    //还有，如果     self.backgroundColor = [UIColor clearColor];。 如果加载到的父视图和 自己颜色不一样，， 我在这里设置了圆角，同时设置了颜色。被剪切的那个正角和 描边的 圆弧形，就形成了对比。有个小角很难看。
    
    self.cellBackView.layer.borderWidth=0.56f; //边框
    self.cellBackView.layer.borderColor=[UIColor grayColor].CGColor;

    self.cellBackView.layer.masksToBounds = YES ;
    self.cellBackView.layer.cornerRadius = 5.0f;
//
    self.backgroundColor = [UIColor clearColor];

}


-(void)setCellbackColor:(UIColor *)cellbackColor
{
    _cellbackColor = cellbackColor ;
}


-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5];  //打开这个就是个圆弧矩形
    CGContextAddPath(ctx, path.CGPath);
    
    UIColor *color;
    color = self.cellbackColor?self.cellbackColor:[UIColor whiteColor];
    
//    CGContextStrokePath(ctx);
    [color setFill];

    CGContextDrawPath(ctx, kCGPathFill); //填充
    UIGraphicsEndImageContext(); //关闭上下文

}


@end
