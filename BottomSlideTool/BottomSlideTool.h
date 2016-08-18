//  Created by Dryen Siu on 16/8/15.
//  Copyright © 2016年 WeiChao. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BottomSlideTool : UIScrollView
/**
 *  传中间页面 工具元素的item View (这里只允许是正方形)
 */
@property(nonatomic,strong)NSArray<UIView*>*data;
-(void)OriginalAutoLayout;
-(void)set3DTransformWithAngle:(CGFloat)angle;


@end
