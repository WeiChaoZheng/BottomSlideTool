//  Created by Dryen Siu on 16/8/15.
//  Copyright © 2016年 WeiChao. All rights reserved.
//

#import "ModelButton.h"
#import "Masonry.h"
@implementation ModelButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        _backgroundImageView = [UIImageView new];
        [self addSubview:_backgroundImageView];
        [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_offset(0);//充满
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
