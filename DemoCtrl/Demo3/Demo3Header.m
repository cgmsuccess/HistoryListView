//
//  Demo3Header.m
//  HistoryListView
//
//  Created by apple on 17/9/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Demo3Header.h"
#import "UIButton+CGMCilckBtn.h"

@interface Demo3Header()<selectHotOrHistoryDelegate>
{
    XC_label *_xcLabel ;
}
@property (weak, nonatomic) IBOutlet UITextField *inputTextfile;

/** 这个属性是：是否 需要toolsview 偏移 ****/
@property (nonatomic,assign)BOOL isOffset ;



@end

@implementation Demo3Header

+(instancetype)loadDemo3headerView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:0][0];
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    _isOffset = YES ;
    
    [self.inputTextfile becomeFirstResponder];
    
    [self toolView];
}


-(void)toolView
{
    NSArray *titleArr = @[@"www.",@".com",@"https://",@"http://",@".cn",@".net",@".int"];
    NSArray *historyArr = @[] ;
    _xcLabel = [[XC_label alloc] initWithFrame:CGRectMake(0, 64 + 51, KmainScreenWidth, 45) AndTitleArr:titleArr AndhistoryArr:historyArr AndTitleFont:16 AndScrollDirection:UICollectionViewScrollDirectionHorizontal]; //水平
    
    /*
     UICollectionViewScrollDirectionHorizontal
     UICollectionViewScrollDirectionVertical
     注意这2个枚举， 如果水平和垂直滑动。那么设置组头 宽度 和 高度 才有对应的效果
     */
    
    _xcLabel.delegate = self ; //实现了代理请务必实现代理方法
    
    _xcLabel.isShow_One = YES ; //第一组的编辑按钮是否显示 默认NO
    _xcLabel.isShow_Two = YES ;
    
    _xcLabel.opetionsColor = [UIColor orangeColor];  //修改选项的颜色。默认白色
    
    _xcLabel.section_widthOne = 0.001; //组头1的宽度
    _xcLabel.opetionsHeight = 33 ; //选项的高度
    
    _xcLabel.backgroundColor = [UIColor cyanColor];
    
    self.inputTextfile.inputAccessoryView = _xcLabel ;
}


#pragma mark selectHotOrHistoryDelegate

-(void)selectHotOrHistory:( NSString * _Nullable )historyOrHot AndIndex:(NSInteger)index AndTitile:(NSString * _Nullable)selectTitle
{
    
    //让他偏移一下，
    if (_isOffset) {
        [_xcLabel setcolletionOffset:CGPointMake(50, 0)];
        _isOffset = NO ;
    }
    
    
    XCLog(@"historyOrHot = %@ , index = %ld , selectTitle = %@" ,historyOrHot ,(long)index ,selectTitle);
    self.inputTextfile.text = [NSString stringWithFormat:@"%@%@",self.inputTextfile.text,selectTitle];
    
    NSString *temp =nil;
    NSString *newString  = nil ;
        //去中间包含的空格
    for(int i =0; i < [self.inputTextfile.text length]; i++)
    {
        temp = [self.inputTextfile.text substringWithRange:NSMakeRange(i,1)];
        XCLog(@"第%d个字是:%@ %@",i,temp,[temp class]);
        if([[NSString stringWithFormat:@"%@",[temp class]] isEqualToString:@"__NSCFString"]&&[temp isEqualToString:@" "]){
            XCLog(@"第%d个字是:%@ %@",i,temp,[temp class]);
        }else{
            if (!newString) {
                newString = @"";
            }
            newString = [NSString stringWithFormat:@"%@%@",newString,temp];
        }
    }
    self.inputTextfile.text = newString ;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
