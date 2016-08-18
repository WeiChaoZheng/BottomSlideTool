//
//  Created by Dryen Siu on 16/8/16.
//  Copyright © 2016年 WeiChao. All rights reserved.
//

#import "CCTailScrollView.h"
#import "Masonry.h"
@interface CCTailScrollView ()
{
    CGFloat selfWidth;
    CGFloat selfHeight;
    
}
@end

@implementation CCTailScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

-(void)setData:(NSArray*)data{
    
    _data = data;
    for (int i = 0; i < data.count; i++)
    {
        UIButton *button = [[UIButton alloc] init];
        button.tag = 3000+i;
        [button setBackgroundImage:[UIImage imageNamed:@"testImage"] forState:0];
        [self addSubview:button];
    }
    
}

-(void)setAutoLayout{
    selfWidth = self.frame.size.width;
    selfHeight = self.frame.size.height;
    self.bounces = YES;
    
    int intoOne  = _data.count%3==0 ?0:1;  // 是否进1
    
    int j = 0;
    for (int k = 0; k<(_data.count/3+intoOne); k++)
    {
        for (int i = 0; i < 3; i++)
        {
            
            
                UIButton *button = [self viewWithTag:3000+j];
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.frame.size.height-(100+2)*(i+1));
                    make.left.mas_offset((100+2)*k);
                    make.width.and.height.mas_equalTo(100);
                }];
                
                j++;
        }
        
    }
    CGFloat contentSizeWidth = (100+2) * (_data.count/3+intoOne);
    
    self.contentSize = CGSizeMake(contentSizeWidth, 0);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
