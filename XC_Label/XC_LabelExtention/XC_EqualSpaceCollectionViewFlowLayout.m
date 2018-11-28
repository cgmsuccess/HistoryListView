//
//  XC_EqualSpaceCollectionViewFlowLayout.m
//  zhutong
//
//  Created by apple on 17/9/29.
//  Copyright © 2017年 com.xc.zhutong. All rights reserved.
// http://www.jianshu.com/p/ac3edf92c5fd -->参考。

#import "XC_EqualSpaceCollectionViewFlowLayout.h"

@interface XC_EqualSpaceCollectionViewFlowLayout()

/** 这个属性是：居中对齐的时候，cell所有的宽度 ，好算间隙****/
@property (nonatomic,assign)CGFloat sumWidth ;

@end

@implementation XC_EqualSpaceCollectionViewFlowLayout


-(instancetype)init
{
    self = [super init];
    if (self) {
        //默认上下垂直滑动
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 5; //左右默认距离
        self.minimumInteritemSpacing = 5; // 上下默认距离
        self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _cellDistance = 5.0; //默认cell距离
        _cellAligntype = XC_collectionAlignTypeCenter; //默认居中
    }
    return self;
}

-(void)setCellDistance:(CGFloat)cellDistance
{
    _cellDistance = cellDistance ;
    self.minimumInteritemSpacing = cellDistance;
    self.minimumLineSpacing = cellDistance ;
}


//返回所有cell的布局属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray * layoutAttributes_t = [super layoutAttributesForElementsInRect:rect];
    NSArray * layoutAttributes = [[NSArray alloc]initWithArray:layoutAttributes_t copyItems:YES];
    
    //if 是水平现实。直接返回系统的布局
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        return layoutAttributes_t ;
    }
    
    // if 是居中显示，那么直接返回系统的布局
    if (_cellAligntype == XC_collectionAlignTypeCenter) {
        return layoutAttributes ;
    }
    

    //用来临时存放一行的Cell数组
    NSMutableArray * layoutAttributesTemp = [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index < layoutAttributes.count ; index++) {
        
        UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[index]; // 当前cell的位置信息
        UICollectionViewLayoutAttributes *previousAttr = index == 0 ? nil : layoutAttributes[index-1]; // 上一个cell 的位置信
        UICollectionViewLayoutAttributes *nextAttr = index + 1 == layoutAttributes.count ?
        nil : layoutAttributes[index+1];//下一个cell 位置信息
        
        //加入临时数组
        [layoutAttributesTemp addObject:currentAttr];
        _sumWidth += currentAttr.frame.size.width;
        
        CGFloat previousY = previousAttr == nil ? 0 : CGRectGetMaxY(previousAttr.frame);
        CGFloat currentY = CGRectGetMaxY(currentAttr.frame);
        CGFloat nextY = nextAttr == nil ? 0 : CGRectGetMaxY(nextAttr.frame);
        //如果当前cell是单独一行
        if (currentY != previousY && currentY != nextY){
            if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                [layoutAttributesTemp removeAllObjects];
                _sumWidth = 0.0;
            }else if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]){
                [layoutAttributesTemp removeAllObjects];
                _sumWidth = 0.0;
            }else{
                [self setCellFrameWith:layoutAttributesTemp];
            }
        }
        //如果下一个cell在本行，这开始调整Frame位置
        else if( currentY != nextY) {
            [self setCellFrameWith:layoutAttributesTemp];
        }
    }
    NSLog(@"---x  这里可以获取到collegetioncell 最后一个cell的高度 rect = %@" , layoutAttributes) ;  ///

    return layoutAttributes;
}

//这调整Frame位置
-(void)setCellFrameWith:(NSMutableArray*)layoutAttributes{
    CGFloat nowWidth = 0.0;
    switch (_cellAligntype) {
        case XC_collectionAlignTypeLeft:
            nowWidth = self.sectionInset.left;
            for (UICollectionViewLayoutAttributes * attributes in layoutAttributes) {
                CGRect nowFrame = attributes.frame;
                nowFrame.origin.x = nowWidth;
                attributes.frame = nowFrame;
                nowWidth += nowFrame.size.width + self.cellDistance;
            }
            _sumWidth = 0.0;
            [layoutAttributes removeAllObjects];
            break;
        case XC_collectionAlignTypeCenter:
            
            //这里永远不会来
            nowWidth = (self.collectionView.frame.size.width - _sumWidth - ((layoutAttributes.count - 1) * _cellDistance)) / 2;
            for (UICollectionViewLayoutAttributes * attributes in layoutAttributes) {
                CGRect nowFrame = attributes.frame;
                nowFrame.origin.x = nowWidth;
                attributes.frame = nowFrame;
                nowWidth += nowFrame.size.width + self.cellDistance;
            }
            _sumWidth = 0.0;
            [layoutAttributes removeAllObjects];
            break;
            
        case XC_collectionAlignTypeRight:
            nowWidth = self.collectionView.frame.size.width - self.sectionInset.right;
            for (NSInteger index = layoutAttributes.count - 1 ; index >= 0 ; index-- ) {
                UICollectionViewLayoutAttributes * attributes = layoutAttributes[index];
                CGRect nowFrame = attributes.frame;
                nowFrame.origin.x = nowWidth - nowFrame.size.width;
                attributes.frame = nowFrame;
                nowWidth = nowWidth - nowFrame.size.width - _cellDistance;
            }
            _sumWidth = 0.0;
            [layoutAttributes removeAllObjects];
            break;
            
    }
}

@end
