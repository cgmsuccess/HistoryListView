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
#import "UIView+XC_Frame.h"

#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define LabelScreenW [UIScreen mainScreen].bounds.size.width
#define LabelScreenH [UIScreen mainScreen].bounds.size.height
#define MyrandomColor [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0f]

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

/**
 是否处于编辑状态
 
 - EditorStateHotDefault: 默认状态
 - EditorStateHotSelect:  编辑状态
 */
typedef NS_ENUM(NSInteger,EditorStateHot){
    EditorStateHotDefault  = 1,
    EditorStateHotSelect
};


@interface XC_label()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
{
    XC_EqualSpaceCollectionViewFlowLayout *layout;
}
@property (nonatomic,strong)UICollectionView *collectionView ;

@property (nonatomic,strong)NSMutableArray *dataSource ; //推荐搜索

@property (nonatomic,strong)NSMutableArray *historySource ;//历史记录

@property (nonatomic,assign)NSInteger labelFont ;//字体大小

@property (nonatomic)EditorStateHistory editorState;//历史记录状态

@property (nonatomic)EditorStateHot editorHotState;//历史记录状态

/** 这个属性是：XCLabel 左右滑动还是上下滑动  。默认上下滑动 ****/
@property (nonatomic) UICollectionViewScrollDirection xcLabel_scrollDirection;
@end

@implementation XC_label


-(instancetype)initWithFrame:(CGRect)frame AndTitleArr:(NSArray *)titleArr AndhistoryArr:(NSArray *)historyArr AndTitleFont:(NSInteger)font AndScrollDirection:(UICollectionViewScrollDirection)xcLabel_scrollDirection
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = [NSMutableArray arrayWithArray:titleArr] ;
        self.historySource = [NSMutableArray arrayWithArray:historyArr];
        self.xcLabel_scrollDirection = xcLabel_scrollDirection;
        self.labelFont = font ;
        self.isShow_One = NO ;
        self.isShow_Two = NO ;
        self.backgroundColor = [UIColor whiteColor];
        self.editorState = EditorStateHistoryDefault ;//默认不编辑
        self.editorHotState = EditorStateHotDefault ;//默认不编辑
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

-(void)reloadHistoryOptions:(NSMutableArray *)historyOptions
{
    self.historySource = historyOptions ;
    [self.collectionView reloadData];
}


#pragma mark 刷新 推荐选项
-(void)reloadHotOptions:(NSMutableArray *)hotOptions
{
    self.dataSource = hotOptions ;
    [self.collectionView reloadData];
}

-(void)deleteHistoryLastOptions
{
    [self.historySource removeLastObject];
    [self.collectionView reloadData];
}




#pragma mark Other
-(void)setShowsHorizontalScrollIndicator:(BOOL)isShow
{
    self.collectionView.showsHorizontalScrollIndicator = isShow ;
}

-(void)setShowsVerticalScrollIndicator:(BOOL)isShow
{
    self.collectionView.showsVerticalScrollIndicator = isShow ;
}

-(void)setOptionLoction:(XC_collectionAlignType)alignType
{
    
    switch (alignType) {
        case XC_collectionAlignTypeRight:
            layout.cellAligntype = XC_collectionAlignTypeRight ;
            break;
        case XC_collectionAlignTypeLeft:
            layout.cellAligntype = XC_collectionAlignTypeLeft ;
            break;
        case XC_collectionAlignTypeCenter:
            layout.cellAligntype = XC_collectionAlignTypeCenter ;
            break;
        default:
            break;
    }
    [self.collectionView reloadData];
}

-(void)setcolletionOffset:(CGPoint)offset AndAnimal:(BOOL)animal
{
    [self.collectionView setContentOffset:offset animated:animal] ;
}


#pragma mark - UICollectionViewDataSource UICollectionViewDelegateFlowLayout
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        // 创建布局
        layout = [[XC_EqualSpaceCollectionViewFlowLayout alloc] init];
        layout.cellDistance = 10;
        layout.cellAligntype = XC_collectionAlignTypeLeft;
        //collectionview 左右滑动还是上下滑动 。默认上下
        layout.scrollDirection = self.xcLabel_scrollDirection;
        // 创建UICollectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.frame = self.bounds;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.showsHorizontalScrollIndicator = NO ;
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
            [self cheakIsCellShowCloseHotBtn:cell];
           //删除
            [cell.closeBtnOutle CgmCilckBtn:UIControlEventTouchUpInside AndCGMCallCback:^(UIButton *btn) {
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(deleteHotOptions:AndIndex:AndTitile:AndNSdataSource:)]) {
                    NSString *s = weakSelf.dataSource[indexPath.row];
                    [weakSelf.dataSource removeObjectAtIndex:indexPath.row]; //删除
                    [weakSelf.delegate deleteHotOptions:s AndIndex:indexPath.row AndTitile:s AndNSdataSource:weakSelf.dataSource];
                    //变为默认状态，取消编辑状态
                    if (weakSelf.editorHotState == EditorStateHotSelect) {
                         weakSelf.editorHotState = weakSelf.dataSource.count == 0?EditorStateHotDefault:EditorStateHotSelect;
                    }
                   
                    [weakSelf.collectionView reloadData];
                }else{
                   
                    NSException *excp = [NSException exceptionWithName:@"deleteError" reason:@"deleteHotOptions:AndIndex:AndTitile:AndNSdataSource:--> 😄🌝😱老铁你这个代理方法没有实现啊。请遵循代理并实现" userInfo:nil];
                    [excp raise];
                }
            }];
            cell.xc_label.text = s ;
        }else{
            //防止没有默认数据的时候，搜索就变成了第一组了
            NSString *s = self.historySource[indexPath.row];
            [self cheakIsCellShowCloseBtn:cell];
            //删除
            [cell.closeBtnOutle CgmCilckBtn:UIControlEventTouchUpInside AndCGMCallCback:^(UIButton *btn) {
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(deleteHistoryOptions:AndIndex:AndTitile:AndNSdataSource:)]) {
                    NSString *s = weakSelf.historySource[indexPath.row];
                    //删除
                    [weakSelf.historySource removeObjectAtIndex:indexPath.row];
                    [weakSelf.delegate deleteHistoryOptions:s AndIndex:indexPath.row AndTitile:s AndNSdataSource:weakSelf.historySource];
                  
                    if (weakSelf.editorState == EditorStateHistorySelect) {
                        weakSelf.editorState = weakSelf.historySource.count == 0?EditorStateHistoryDefault:EditorStateHistorySelect;
                    }
                    
                    [weakSelf.collectionView reloadData];
                }else{
                    NSException *excp = [NSException exceptionWithName:@"deleteError" reason:@"deleteHistoryOptions:AndIndex:AndTitile:AndNSdataSource:--> 😄🌝😱老铁你这个代理方法没有实现啊。请遵循代理并实现" userInfo:nil];
                    [excp raise];
                }
            }];
            cell.xc_label.text = s;
        }
    }else{
        NSString *s = self.historySource[indexPath.row];
        cell.xc_label.text = s;
        [self cheakIsCellShowCloseBtn:cell];
        //删除
        [cell.closeBtnOutle CgmCilckBtn:UIControlEventTouchUpInside AndCGMCallCback:^(UIButton *btn) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(deleteHistoryOptions:AndIndex:AndTitile:AndNSdataSource:)]) {
                NSString *s = weakSelf.historySource[indexPath.row];
                [weakSelf.historySource removeObjectAtIndex:indexPath.row];

                [weakSelf.delegate deleteHistoryOptions:s AndIndex:indexPath.row AndTitile:s AndNSdataSource:weakSelf.historySource];
                
                if (weakSelf.editorState == EditorStateHistorySelect) {
                    weakSelf.editorState = weakSelf.historySource.count == 0?EditorStateHistoryDefault:EditorStateHistorySelect;
                }
                [weakSelf.collectionView reloadData];
            }else{
                NSException *excp = [NSException exceptionWithName:@"deleteError" reason:@"deleteHistoryOptions:AndIndex:AndTitile:AndNSdataSource:--> 😄🌝😱老铁你这个代理方法没有实现啊。请遵循代理并实现" userInfo:nil];
                [excp raise];
            }
        }];
    }
        
    cell.cellbackColor = self.opetionsColor?self.opetionsColor:[UIColor whiteColor];
    [cell setNeedsDisplay];  //一定要重绘，不然计算不精准，我们设置的选项的地图就不对
    
    if (indexPath.item == self.dataSource.count - 1) {
        CGRect rect = [cell convertRect:cell.frame toView:self];
        NSLog(@"xx  -- rect  = %@" , NSStringFromCGRect(rect));
        NSLog(@"self.view = %@",NSStringFromCGRect(self.bounds));
        NSLog(@"%@", self.dataSource[indexPath.row]);
    }
    return cell;
}

////定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) { //推荐搜索
        if (self.dataSource.count !=0) {
            NSString *s = self.dataSource[indexPath.row];
            CGFloat f = [self opnetionsWidth:s];
            return CGSizeMake(f + 16  ,self.opetionsHeight?self.opetionsHeight:40);
        }else{
            NSString *s = self.historySource[indexPath.row];
            CGFloat f = [self opnetionsWidth:s];
            return CGSizeMake(f + 16  ,self.opetionsHeight?self.opetionsHeight:40);
        }
    }else{
        NSString *s = self.historySource[indexPath.row];
        CGFloat f = [self opnetionsWidth:s];
        return CGSizeMake(f + 16  ,self.opetionsHeight?self.opetionsHeight:40);
    }
}

/**  选项的宽度，如果超出屏幕大小不显示，显示。。。   */
-(CGFloat)opnetionsWidth:(NSString *)opentioString
{
    CGFloat f = [self autoWidthWithString:opentioString Font:self.labelFont];
    if (f > LabelScreenW) {
        f = LabelScreenW -24 ;
    }
    return f ;
}

/**  动态计算高度   */
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
                headerView.headerLabel.text = self.headTitle_one?self.headTitle_one:@"推荐新闻";
                headerView.editorOutle.hidden = self.isShow_One ;
               
                [weakSelf cheakIsEditorHotState:headerView];

                [headerView.editorOutle CgmCilckBtn:UIControlEventTouchUpInside AndCGMCallCback:^(UIButton *btn) {
                    if (weakSelf.editorHotState == EditorStateHotDefault) { //默认状态
                        weakSelf.editorHotState = EditorStateHotSelect ; //进入编辑状态
                    }else if (weakSelf.editorHotState == EditorStateHotSelect) {
                        weakSelf.editorHotState = EditorStateHotDefault ;
                    }
                    weakSelf.editorHotState = headerView.editorOutle.selected?EditorStateHotDefault:EditorStateHotSelect;
                    
                    [weakSelf.collectionView reloadData];
                }];
            }else{
                //当没有推荐新闻时候，有历史搜索的时候
                headerView.headerLabel.text = self.headTitle_two?self.headTitle_two:@"历史搜索";
                [weakSelf cheakIsEditorState:headerView];
                headerView.editorOutle.hidden = self.isShow_Two ;
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
            headerView.editorOutle.hidden = self.isShow_Two ;

            headerView.headerLabel.text = @"历史搜索";
            [weakSelf cheakIsEditorState:headerView];
            [headerView.editorOutle CgmCilckBtn:UIControlEventTouchUpInside AndCGMCallCback:^(UIButton *btn) {
                if (weakSelf.editorState == EditorStateHistoryDefault) { //默认状态
                    weakSelf.editorState = EditorStateHistorySelect ;
                }else if (weakSelf.editorState == EditorStateHistorySelect) {
                    weakSelf.editorState = EditorStateHistoryDefault ;
                }
                weakSelf.editorState = headerView.editorOutle.selected?EditorStateHistoryDefault:EditorStateHistorySelect;
              //  XCLog(@"%d" ,weakSelf.editorState) ;
                [weakSelf.collectionView reloadData];
            }];
        }
        return headerView;
    }
    return nil;
}

//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat header_width ;
    CGFloat header_height ;
    if (section == 0) {
        header_height = self.section_heihtOne?self.section_heihtOne:40;
        header_width = self.section_widthOne?self.section_widthOne:LabelScreenW ;
       return  CGSizeMake(header_width, header_height);
    }
    header_height = self.section_heihtTwo?self.section_heihtTwo:40;
    header_width = self.section_widthTwo?self.section_widthTwo:LabelScreenH ;
   return  CGSizeMake(header_width, header_height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XC_labelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (indexPath.section == 0) { //推荐搜索
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectHotOrHistory:AndIndex:AndTitile:)]) {
            NSString *title ; //选择的哪一组的标题
            if (self.dataSource.count !=0) {
                NSString *s = self.dataSource[indexPath.row];
                title = self.headTitle_one?self.headTitle_one:@"推荐新闻";
                [self.delegate selectHotOrHistory:title AndIndex:indexPath.row AndTitile:s];
            }else{
                NSString *s = self.historySource[indexPath.row];
                title = self.headTitle_two?self.headTitle_two:@"历史搜索";
                [self.delegate selectHotOrHistory:title AndIndex:indexPath.row AndTitile:s];
            }
                
            }else{
                NSException *excp = [NSException exceptionWithName:@"deleteError" reason:@"selectHotOrHistory:AndIndex:AndTitile:--> 😄🌝😱老铁你这个代理方法没有实现啊。请遵循代理并实现" userInfo:nil];
                [excp raise];
            }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectHotOrHistory:AndIndex:AndTitile:)]) {
            NSString *s = self.historySource[indexPath.row];
           NSString * title = self.headTitle_two?self.headTitle_two:@"历史搜索";
            [self.delegate selectHotOrHistory:title AndIndex:indexPath.row AndTitile:s];
        }else{
            NSException *excp = [NSException exceptionWithName:@"deleteError" reason:@"selectHotOrHistory:AndIndex:AndTitile:--> 😄🌝😱老铁你这个代理方法没有实现啊。请遵循代理并实现" userInfo:nil];
            [excp raise];
        }
    }
    [self resume:cell];
    self.editorState = EditorStateHistoryDefault ;
    [self.collectionView reloadData];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//每个item 之间的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5.0f;
}


#pragma mark method
/**
  第二组 判断是否是编辑状态 。 历史记录
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
    
    headerView.editorOutle.hidden = self.isShow_Two ;
}

/**
 第一组 判断是否是编辑状态 。 推荐选项

 @param headerView XC_labelCollectionViewCell
 */
-(void)cheakIsEditorHotState:(XC_LabelHeaderCollectionReusableView *)headerView
{

    WS(weakSelf);
    if (weakSelf.editorHotState == EditorStateHotDefault) {
        headerView.editorOutle.selected = NO ;
        headerView.editorOutle.hidden = NO;
    }else  if (weakSelf.editorHotState == EditorStateHotSelect) {
        headerView.editorOutle.selected = YES ;
        headerView.editorOutle.hidden = NO;
    }
    
    headerView.editorOutle.hidden = self.isShow_One ;
}


/**
 是否显示 删除按钮  历史搜索 ，即第二组

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

/**
 是否显示 删除按钮  推荐搜索 ，即第一组

 @param cell XC_labelCollectionViewCell
 */
-(void)cheakIsCellShowCloseHotBtn:(XC_labelCollectionViewCell *)cell{
    WS(weakSelf);
    if (weakSelf.editorHotState == EditorStateHotSelect) {
        cell.closeBtnOutle.hidden = NO ;
        [self starLongPress:cell];
    }else  if (weakSelf.editorHotState == EditorStateHotDefault) {
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
    
    if (cell.xc_size.width > LabelScreenW / 2) {
        //抖动角度
        animation.fromValue = @(-M_1_PI/30);
        animation.toValue = @(M_1_PI/30);
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
