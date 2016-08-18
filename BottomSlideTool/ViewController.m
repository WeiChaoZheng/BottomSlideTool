//
//  ViewController.m
//  BottomSlideTool
//
//  Created by Dryen Siu on 16/8/18.
//  Copyright © 2016年 WeiChao. All rights reserved.
//
#import "ViewController.h"
#import "CCTableViewCell.h"
#import "CCFirstCollectionView.h"
#import "CCTailScrollView.h"
#import "Masonry.h"   //第三方约束布局
#import "BottomSlideTool.h"
#import "ModelButton.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    CGFloat firstX;
    CGFloat endX;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)BottomSlideTool *bottomSlideTool;
@property(nonatomic,strong)UIView *shadeView;//全屏遮罩
@property(nonatomic,strong)CCTailScrollView *tailView;
//@property(nonatomic,strong)
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = 0;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate =self;
    
    self.tableView.dataSource =self;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CCTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier: @"cellIdentifier"];
    
    
    [self.view addSubview:self.tableView];
    //tableView 的约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.mas_offset(0);
        make.width.mas_offset(ScreenWidth);
        make.height.mas_offset(ScreenHeight-20);
    }];
    
    
#pragma mark -遮罩
    _shadeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];//全屏遮罩
    _shadeView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.35];
    _shadeView.alpha = 0;//默认隐藏
    [self.view addSubview:_shadeView];
    
#pragma mark - ScrollView 的自定义子类
    _bottomSlideTool = [[BottomSlideTool alloc] init];
    //    _view3d.hidden = YES; //默认是隐藏的
    
    //设置代理,注意要在 UIScrollViewDelegate 里面做判断,区别tableView;
    _bottomSlideTool.delegate = self;
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i = 0; i < 9; i++)
    {
        ModelButton *item = [[ModelButton alloc] init];
        item.backgroundImageView.image = [UIImage imageNamed:@"testImage"];
        [itemArr addObject:item];
    }
    //先设置item 再设置约束
    _bottomSlideTool.data = itemArr;
    [_bottomSlideTool OriginalAutoLayout];
    [self.view addSubview:_bottomSlideTool];
    [_bottomSlideTool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.width.mas_offset(ScreenWidth);
        make.height.mas_offset(ScreenHeight);
    }];
    
    //左边首部 View
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"自定义控件View";
    label.textAlignment = 1;
    label.textColor = [UIColor whiteColor];
    [view1 addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(200);
        make.height.mas_offset(21);
        make.centerX.equalTo(view1.mas_centerX);
        make.centerY.equalTo(view1.mas_centerY);
        
    }];
    view1.backgroundColor = [UIColor grayColor];
    
    [_bottomSlideTool addSubview:view1];
    
    
    
    //右边尾部View
    _tailView = [[CCTailScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    _tailView.delegate = self;
    [_bottomSlideTool addSubview:_tailView];
    [_tailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(ScreenWidth*2);
        make.width.and.height.mas_offset(ScreenWidth);
        make.top.mas_offset(ScreenHeight-ScreenWidth);
    }];
    _tailView.data = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    [_tailView setAutoLayout];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    [cell.showImageView setImage:[UIImage imageNamed:@"testImage"]];
    return cell;
    
}
//设置滑动事件
#pragma mark - UIScrollViewDelegate --
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat bili = scrollView.contentOffset.x/ScreenWidth -1;
    if ([scrollView isKindOfClass:[BottomSlideTool class]])
    {
        //            [scrollView nextResponder];
        [_bottomSlideTool set3DTransformWithAngle:bili*M_PI_2];
        
        _shadeView.alpha = fabs(bili);//取绝对值
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
