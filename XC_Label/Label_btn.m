//
//  Label_btn.m
//  zhutong
//
//  Created by apple on 17/7/3.
//  Copyright © 2017年 com.xc.zhutong. All rights reserved.
//

#import "Label_btn.h"

@implementation Label_btn

-(void)layoutSubviews{
    [super layoutSubviews];

    [self.titleLabel sizeToFit];
    
    self.titleLabel.xc_x = self.xc_width - self.titleLabel.xc_width;
    
    self.titleLabel.xc_y = 0;
    
    
    
}

@end
