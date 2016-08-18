//  Created by Dryen Siu on 16/8/15.
//  Copyright © 2016年 WeiChao. All rights reserved.
//

#import "BottomSlideTool.h"
#import "Masonry.h"
#import "ModelButton.h"
#import "UIImageView+WebCache.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface BottomSlideTool ()

{
    CGSize itemSize;
}

@end

@implementation BottomSlideTool
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        
        self.contentSize = CGSizeMake(ScreenWidth*3, 0);
        [self setContentOffset:CGPointMake(ScreenWidth, 0)];
    }
    return self;
}


-(void)setData:(NSArray<UIView*>*)data
{
    _data = data;
    CGFloat itemWidth = ScreenWidth/data.count;
    itemSize = CGSizeMake(itemWidth, itemWidth);//这里这个工具是正方形
    
    for (int i = 0; i < data.count; i++)
    {
        UIView *item = data[i];
        item.tag = 2000+i;  //用tag打标记
        [self addSubview:item];
    }
}

/**
 *  设置工具栏的Frame
 */

-(void)OriginalAutoLayout
{
   
    for (int i = 0; i < _data.count; i++)
    {
        
        UIView *item = [self viewWithTag:2000+i];
        
//        button.frame = CGRectMake(ScreenWidth+itemSize.width*(i), 0, itemSize.width, itemSize.width);
        [item mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(ScreenHeight - itemSize.height);
            make.left.mas_offset(ScreenWidth+itemSize.width*(i));
            make.width.and.height.mas_offset(itemSize.width);
            
        }];
        
        
        
        
        
    }

}
-(void)set3DTransformWithAngle:(CGFloat)angle
{
    CGFloat bili = angle/M_PI_2;
//    NSLog(@"bili:%f",bili);
    int count = (int)_data.count;
    for (int i = 0; i<_data.count ; i++) {
        UIView *item = [self viewWithTag:2000+i];
        if(bili>0){
            item.layer.anchorPoint = CGPointMake(0, 0.5);
            CGFloat temp = itemSize.width*(i+1)*(1-bili);
            [item mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_offset(ScreenHeight - itemSize.height);
                make.left.mas_offset(ScreenWidth+ScreenWidth*(count*2-1)/(count*2)-temp);  //使用约束和使用frame 计算的数值不一样,应该是和锚点有关
                make.width.and.height.mas_offset(itemSize.width);
                
            }];

        }else{
            item.layer.anchorPoint = CGPointMake(1, 0.5);
            CGFloat temp = itemSize.width*(i+1)*(1+bili);
            [item mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_offset(ScreenHeight - itemSize.height);
                make.left.mas_offset(ScreenWidth*(count*2-1)/(count*2) + temp);//使用约束和使用frame 计算的数值不一样,应该是和锚点有关
                
                make.width.and.height.mas_offset(itemSize.width);
                
            }];

        }
        
        // ---------------------------------3D翻转---------------------------------------------------------------
        CATransform3D scale = CATransform3DIdentity;
        scale.m34 = 4.5/-2000;
        //y轴翻转
        item.layer.transform =  CATransform3DRotate(scale, angle, 0, 1, 0);
        //------------------------------------------------------------------------------------------------------
    }
  
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
//    NSLog(@"point:%@",[NSValue valueWithCGPoint:point]);
    
//    点击中间的透明的空白处的话,self就不响应UITouch事件
    //这里约束完显示出视图之后 是能取到Frame 的
    
    if (self.frame.size.height - point.y < itemSize.height||self.contentOffset.x ==0  ||self.contentOffset.x >= ScreenWidth*2)
    {
        return YES;
    }else
    {
        return NO;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
