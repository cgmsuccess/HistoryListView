//
//  UIView+XC_Frame.m
//  HistoryListView
//
//  Created by apple on 17/9/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIView+XC_Frame.h"

@implementation UIView (XC_Frame)
/*
 @property有两个对应的词，一个是@synthesize，一个是@dynamic。如果@synthesize和@dynamic都没写，那么默认的就是@syntheszie var = _var;

 @synthesize的语义是如果你没有手动实现setter方法和getter方法，那么编译器会自动为你加上这两个方法。
 
 @dynamic告诉编译器,属性的setter与getter方法由用户自己实现，不自动生成。
 */
@dynamic xc_x;
@dynamic xc_y;

@dynamic xc_centerX;
@dynamic xc_centerY;

@dynamic xc_right;
@dynamic xc_bottom;
@dynamic xc_top;
@dynamic xc_left;

@dynamic xc_height;
@dynamic xc_width;


@dynamic xc_origin;
@dynamic xc_size;


/**  X   */
-(void)setXc_x:(CGFloat)xc_x
{
    CGRect frame = self.frame ;
    frame.origin.x = xc_x ;
    self.frame = frame ;
}

-(CGFloat)xc_x
{
    return self.frame.origin.x ;
}

/**  Y   */

-(void)setXc_y:(CGFloat)xc_y
{
    CGRect frame = self.frame ;
    frame.origin.y = xc_y;
    self.frame = frame ;
}

-(CGFloat)xc_y
{
    return self.frame.origin.y;
}

/**   CenterX  */
-(void)setXc_centerX:(CGFloat)xc_centerX
{
    CGPoint center = self.center;
    center.x = xc_centerX;
    self.center = center;
}

-(CGFloat)xc_centerX
{
    return self.center.x   ;
}

/**  CenterY   */
-(void)setXc_centerY:(CGFloat)xc_centerY
{
    CGPoint center = self.center;
    center.y = xc_centerY;
    self.center = center;
}


- (CGFloat)xc_centerY {
    return self.center.y;
}

/**  Width   */
-(void)setXc_width:(CGFloat)xc_width
{
    CGRect frame = self.frame;
    frame.size.width = xc_width;
    self.frame = frame;
}


- (CGFloat)xc_width {
    return self.frame.size.width;
}

/**  Heiht   */
-(void)setXc_height:(CGFloat)xc_height
{
    CGRect frame = self.frame;
    frame.size.height = xc_height;
    self.frame = frame ;
    
}

-(CGFloat)xc_height
{
    return self.frame.size.height;
}
/**  Size   */
-(CGSize)xc_size
{
    return self.frame.size;
}

-(void)setXc_size:(CGSize)xc_size
{
    CGRect frame = self.frame ;
    frame.size = xc_size ;
    self.frame = frame ;
}

/**  Origin   */
-(void)setXc_origin:(CGPoint)xc_origin
{
    CGRect frame =  self.frame ;
    frame.origin = xc_origin;
    self.frame = frame;
}

-(CGPoint)xc_origin
{
    return self.frame.origin;
}

/**  Top   */
-(void)setXc_top:(CGFloat)xc_top
{
    CGRect frame = self.frame ;
    frame.origin.y = xc_top ;
    self.frame = frame ;
}

-(CGFloat)xc_top
{
    return self.frame.origin.y;
}

/**  left   */
-(CGFloat)xc_left
{
    return self.frame.origin.x ;
}

-(void)setXc_left:(CGFloat)xc_left
{
    CGRect frame = self.frame ;
    frame.origin.x = xc_left ;
    self.frame = frame ;
}

/**  bottom   */
-(CGFloat)xc_bottom
{
    return self.frame.size.height + self.frame.origin.y ;
}

-(void)setXc_bottom:(CGFloat)xc_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = xc_bottom - frame.size.height ;
    self.frame = frame ;
}

/**  right   */
-(CGFloat)xc_right
{
    return self.frame.size.width + self.frame.origin.x ;
}

-(void)setXc_right:(CGFloat)xc_right
{
    CGRect frame = self.frame ;
    frame.origin.x = xc_right - frame.size.width;
    self.frame = frame ;

}

@end
