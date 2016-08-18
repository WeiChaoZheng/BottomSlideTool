//  Created by Dryen Siu on 16/8/16.
//  Copyright © 2016年 WeiChao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  右侧尾部的自定义控件
 */
@interface CCTailScrollView : UIScrollView

@property(nonatomic,strong)NSArray *data;
-(void)setAutoLayout;
@end
