//
//  CGM_Label.m
//  标签
//
//  Created by apple on 17/6/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XC_label.h"
#import "XC_labelCollectionViewCell.h"
#import "XC_LabelHeaderCollectionReusableView.h"
#import "UIButton+CGMCilckBtn.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define LabelScreenW [UIScreen mainScreen].bounds.size.width
#define LabelScreenH [UIScreen mainScreen].bounds.size.height
#define MyrandomColor [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0f]

static CGFloat const margin = 1;
static NSString *const ID = @"cell";
static NSString *const headerID = @"headerID";

/**
 是否处于编辑状态

 - EditorStateHistoryDefault: 默认状态
 - EditorStateHistorySelect:  编辑状态
 */
typedef NS_ENUM(NSInteger,EditorStateHistory){
    EditorStateHistoryDefault  = 1,
    EditorStateHistorySelect
};

@interface XC_label()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView *collectionView ;

@property (nonatomic,strong)NSMutableArray *dataSource ; //推荐搜索

@property (nonatomic,strong)NSMutableArray *historySource ;//历史记录

@property (nonatomic,assign)NSInteger labelFont ;//字体大小

@property (nonatomic,assign)EditorStateHistory editorState;//历史记录状态

@end

@implementation XC_label


-(instancetype)initWithFrame:(CGRect)frame AndTitleArr:(NSArray *)titleArr AndhistoryArr:(NSArray *)historyArr AndTitleFont:(NSInteger)font
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = [NSMutableArray arrayWithArray:titleArr] ;
        self.historySource = [NSMutableArray arrayWithArray:historyArr];
        self.labelFont = font ;
        NSLog(@"titleArr = %@ ,%@" ,titleArr  ,self.dataSource) ;
        self.editorState = EditorStateHistoryDefault ;//默认为未选择
        [self  addSubview:self.collectionView];
        
    }
    return self ;
}


#pragma mark 插入历史记录
-(void)insertHistorOptions:(NSString *)options
{
    [self.historySource insertObject:options atIndex:0];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark - UICollectionViewDataSource
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        // 创建布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = margin;
        layout.minimumLineSpacing = margin;
        
        // 创建UICollectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds   collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.frame = self.bounds;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        // 注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"XC_labelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"XC_LabelHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    }
    
    return _collectionView ;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.historySource.count == 0 && self.dataSource.count == 0) {
        return  0 ;
    }
    if (self.dataSource.count != 0 && self.historySource.count != 0) {
        return 2;
    }
    
    return  1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) { //推荐搜索
        if (self.dataSource.count !=0) {
            return  self.dataSource.count;
        }else{
            return self.historySource.count ;
        }
    }else{
        return self.historySource.count ;
    }
    return   self.historySource.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WS(weakSelf);
    XC_labelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (indexPath.section == 0) { //推荐搜索
        if (self.dataSource.count !=0) {
            NSString *s = self.dataSource[indexPath.row];
            cell.xc_label.text = s ;
            cell.closeBtnOutle.hidden = YES ;
        }else{
            NSString *s = self.historySource[indexPath.row];
            [self cheakIsCellShowCloseBtn:cell];
            [cell.closeBtnOutle CgmCilckBtn:UIControlEventTouchUpInside AndCGMCallCback:^(UIButton *btn) {
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(deleteHistoryOptions:AndIndex:AndTitile:)]) {
                    NSString *s = weakSelf.historySource[indexPath.row];
                    [weakSelf.delegate deleteHistoryOptions:s AndIndex:indexPath.row AndTitile:s];
                    [weakSelf.historySource removeObjectAtIndex:indexPath.row];
                    [weakSelf.collectionView reloadData];
                }
            }];
            
            cell.xc_label.text = s;
        }
    }else{
        NSString *s = self.historySource[indexPath.row];
        cell.xc_label.text = s;
        [self cheakIsCellShowCloseBtn:cell];
        [cell.closeBtnOutle CgmCilckBtn:UIControlEventTouchUpInside AndCGMCallCback:^(UIButton *btn) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(deleteHistoryOptions:AndIndex:AndTitile:)]) {
                NSString *s = weakSelf.historySource[indexPath.row];
                [weakSelf.delegate deleteHistoryOptions:s AndIndex:indexPath.row AndTitile:s];
                [weakSelf.historySource removeObjectAtIndex:indexPath.row];
                [weakSelf.collectionView reloadData];
            }
        }];
    }    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) { //推荐搜索
        if (self.dataSource.count !=0) {
            NSString *s = self.dataSource[indexPath.row];
            CGFloat f = [self autoWidthWithString:s Font:self.labelFont];
            if (f > LabelScreenW) {
                f = LabelScreenW -24 ;
            }
            return CGSizeMake(f + 16  ,40);
        }else{
            NSString *s = self.historySource[indexPath.row];
            CGFloat f = [self autoWidthWithString:s Font:self.labelFont];
            if (f > LabelScreenW) {
                f = LabelScreenW -24 ;
            }
            return CGSizeMake(f + 16  ,40);
        }
    }else{
        NSString *s = self.historySource[indexPath.row];
        CGFloat f = [self autoWidthWithString:s Font:self.labelFont];
        if (f > LabelScreenW) {
            f = LabelScreenW -24 ;
        }
        return CGSizeMake(f + 16  ,40);
    }
}

-(CGFloat)autoWidthWithString:(NSString *)string Font:(NSInteger)font {
    
    //大小
    CGSize boundRectSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    //绘制属性（字典）
    NSDictionary *fontDict = @{ NSFontAttributeName: [UIFont systemFontOfSize:font]};
    //调用方法,得到宽度
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:fontDict context:nil].size.width;
    return newFloat;
}


// 获取头/尾视图:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XC_LabelHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        headerView.backgroundColor = Color(238, 238, 238, 1);

        if (indexPath.section == 0) { //推荐搜索
            if (weakSelf.dataSource.count !=0) {
                headerView.headerLabel.text = @"推荐新闻";
                headerView.editorOutle.hidden = YES ;
            }else{
                headerView.headerLabel.text = @"历史搜索";
                [weakSelf cheakIsEditorState:headerView];
                
                [headerView.editorOutle CgmCilckBtn:UIControlEventTouchUpInside AndCGMCallCback:^(UIButton *btn) {
                    if (weakSelf.editorState == EditorStateHistoryDefault) { //默认状态
                        weakSelf.editorState = EditorStateHistorySelect ; //进入编辑状态
                    }else if (weakSelf.editorState == EditorStateHistorySelect) {
                        weakSelf.editorState = EditorStateHistoryDefault ;
                    }
                    weakSelf.editorState = headerView.editorOutle.selected?EditorStateHistoryDefault:EditorStateHistorySelect;
                    
                    [weakSelf.collectionView reloadData];
                }];
            }
        }else{
            headerView.headerLabel.text = @"历史搜索";
            [weakSelf cheakIsEditorState:headerView];
            [headerView.editorOutle CgmCilckBtn:UIControlEventTouchUpInside AndCGMCallCback:^(UIButton *btn) {
                if (weakSelf.editorState == EditorStateHistoryDefault) { //默认状态
                    weakSelf.editorState = EditorStateHistorySelect ;
                }else if (weakSelf.editorState == EditorStateHistorySelect) {
                    weakSelf.editorState = EditorStateHistoryDefault ;
                }
                weakSelf.editorState = headerView.editorOutle.selected?EditorStateHistoryDefault:EditorStateHistorySelect;
              //  CGMLog(@"%d" ,weakSelf.editorState) ;
                [weakSelf.collectionView reloadData];
            }];
        }
        return headerView;
    }
    return nil;
}

//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(LabelScreenW, 44);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) { //推荐搜索
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectHotOrHistory:AndIndex:AndTitile:)]) {
                
            if (self.dataSource.count !=0) {
                NSString *s = self.dataSource[indexPath.row];
                [self.delegate selectHotOrHistory:@"推荐新闻" AndIndex:indexPath.row AndTitile:s];
            }else{
                NSString *s = self.historySource[indexPath.row];
                [self.delegate selectHotOrHistory:@"历史搜索" AndIndex:indexPath.row AndTitile:s];
            }
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectHotOrHistory:AndIndex:AndTitile:)]) {
            NSString *s = self.historySource[indexPath.row];
            [self.delegate selectHotOrHistory:@"历史搜索" AndIndex:indexPath.row AndTitile:s];
        }
    }
}

#pragma mark method
/**
 判断是否是编辑状态
 */
-(void)cheakIsEditorState:(XC_LabelHeaderCollectionReusableView *)headerView
{
    WS(weakSelf);
    if (weakSelf.editorState == EditorStateHistoryDefault) {
        headerView.editorOutle.selected = NO ;
        headerView.editorOutle.hidden = NO;
    }else  if (weakSelf.editorState == EditorStateHistorySelect) {
        headerView.editorOutle.selected = YES ;
        headerView.editorOutle.hidden = NO;
    }
}

/**
 是否显示 删除按钮

 @param cell XC_labelCollectionViewCell
 */
-(void)cheakIsCellShowCloseBtn:(XC_labelCollectionViewCell *)cell{
    WS(weakSelf);
    if (weakSelf.editorState == EditorStateHistorySelect) {
        cell.closeBtnOutle.hidden = NO ;
        [self starLongPress:cell];
    }else  if (weakSelf.editorState == EditorStateHistoryDefault) {
        cell.closeBtnOutle.hidden = YES ;
        [self resume:cell];
    }
}


//开始抖动
- (void)starLongPress:(XC_labelCollectionViewCell*)cell{
    CABasicAnimation *animation = (CABasicAnimation *)[cell.layer animationForKey:@"rotation"];
    if (animation == nil) {
        [self shakeImage:cell];
    }else {
        [self resume:cell];
    }
}

- (void)resume:(XC_labelCollectionViewCell*)cell {
    cell.layer.speed = 1.0;
}


- (void)shakeImage:(XC_labelCollectionViewCell*)cell {
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置属性，周期时长
    [animation setDuration:0.08];
    
    if (cell.frame.size.width > LabelScreenW / 2) {
        //抖动角度
        animation.fromValue = @(-M_1_PI/20);
        animation.toValue = @(M_1_PI/20);
    }else{
        //抖动角度
        animation.fromValue = @(-M_1_PI/6);
        animation.toValue = @(M_1_PI/6);
    }

    //重复次数，无限大
    animation.repeatCount = HUGE_VAL;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    cell.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [cell.layer addAnimation:animation forKey:@"rotation"];
}


@end
