//
//  ViewController.m
//  topView
//
//  Created by yinxiangfu on 15/11/30.
//  Copyright © 2015年 xf. All rights reserved.
//

#import "ViewController.h"

static NSString *homeImgs[] = {@"index_btn_safe_down",@"index_btn_zijin_down",@"index_btn_jiaoyi_down"};

@interface TopView : UIView
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *headerImgView;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIButton *getButton;
@property (nonatomic, strong) UIButton *saveButton;
@end

@implementation TopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttons = [NSMutableArray array];
        self.clipsToBounds = YES;
        [self initMyView];
    }
    return self;
}

- (void)initMyView
{
//    self.headerImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
//    self.headerImgView.image = [UIImage imageNamed:@"me_img_user"];
//    [self addSubview:_headerImgView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.text = @"e2e12321312";
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_nameLabel];
    
    for (int i=0; i<3; i++) {
        UIImage  *img       = [UIImage imageNamed:homeImgs[i]];
        
        UIButton *button    = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:img forState:UIControlStateNormal];
        button.tag = 100-i;
        button.frame = CGRectMake(0, 0, 25, 25);
        [self addSubview:button];
        [_buttons addObject:button];
    }
    
    self.getButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getButton setBackgroundColor:[UIColor orangeColor]];
    self.getButton.layer.cornerRadius = 5.f;
    self.getButton.clipsToBounds = YES;
    [self.getButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getButton setTitle:@"提现" forState:UIControlStateNormal];
    self.getButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:_getButton];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saveButton setBackgroundColor:[UIColor orangeColor]];
    self.saveButton.layer.cornerRadius = 5.f;
    self.saveButton.clipsToBounds = YES;
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveButton setTitle:@"充值" forState:UIControlStateNormal];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [self addSubview:_saveButton];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.getButton.frame = CGRectMake(15, 150, 150, 50);
    if (CGRectGetHeight(self.frame)>220) {
        CGRect rect = self.getButton.frame;
        rect.origin.y += (self.frame.size.height-220);
        self.getButton.frame = rect;
    }
    self.getButton.clipsToBounds = YES;
    self.saveButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-150-15, self.getButton.frame.origin.y, 150, 50);
    self.saveButton.clipsToBounds = YES;
    self.nameLabel.frame = CGRectMake(100, self.getButton.frame.origin.y-80, 100, 40);
    
    for (int i = 0; i < self.buttons.count; i ++) {
        UIButton *bt = self.buttons[i];
        bt.frame = CGRectMake(100+i*(CGRectGetWidth(bt.frame)+10), CGRectGetMaxY(self.nameLabel.frame), bt.frame.size.width, bt.frame.size.height);
        [bt addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    
//    self.headerImgView.frame = CGRectMake(15, self.frame.size.height-130, 50, 50);
}

- (void)click
{
    NSLog(@"click");
}


@end

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIView *headTopView;
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UIImageView *headImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.clipsToBounds = NO;
    CGRect rect = self.view.bounds;
    CGFloat topHeight = 220;
    
    UIImageView *bgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rect), 360)];
    bgImgV.image = [UIImage imageNamed:@"index_img_pic"];
    [self.view addSubview:bgImgV];
    
    _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.clipsToBounds = NO;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView.contentInset = UIEdgeInsetsMake(topHeight, 0, 200, 0);
    [self.view addSubview:_myTableView];
    
    TopView *topView = [[TopView alloc] initWithFrame:CGRectMake(0, -topHeight, CGRectGetWidth(rect), topHeight)];
    topView.backgroundColor = [UIColor clearColor];
    [_myTableView addSubview:topView];
    self.headTopView = topView;
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rect), 64)];
    barView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:barView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-25, 20, 50, 44)];
    titleLabel.text = @"测试";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    [barView addSubview:titleLabel];
    self.topBarView = barView;
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.headImageView.image = [UIImage imageNamed:@"me_img_user"];
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2;

    [self.view addSubview:_headImageView];
    self.headImageView.center = CGPointMake(30, (self.headTopView.frame.size.height-110));
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.headImageView addGestureRecognizer:tap];
    self.headImageView.userInteractionEnabled = YES;
}

- (void)tap
{
    NSLog(@"headImg");
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = nil;

    if (indexPath.section == 0) {
        cell.textLabel.text = @"累计收益";
    }else if (indexPath.section == 1){
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else if (indexPath.section == 2){
        cell.textLabel.text = @"数据";
    }else if (indexPath.section == 3){
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else if (indexPath.section == 4){
        cell.textLabel.text = @"我的东东";
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 111;
    }
    else if (indexPath.section ==1)
    {
        return 20;
    }
    else if (indexPath.section ==2)
    {
        return 44;
    }
    else if (indexPath.section ==3)
    {
        return 20;
    }
    else
    {
        return 120;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
//    NSLog(@"%f",scrollView.contentOffset.y);
//    if (scrollView.contentOffset.y <= -64) {
//        *targetContentOffset = CGPointMake(0, -scrollView.contentInset.top);
//
//    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"2");
//    [scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"3");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"%f",scrollView.contentOffset.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat alpha = (scrollView.contentOffset.y+220)/(220-64);
    if (alpha > 1) {
        alpha = 1;
    }else if (alpha < 0){
        alpha = 0;
    }

    [_topBarView setBackgroundColor:[UIColor colorWithRed:255/255.f green:151/255.f blue:58/255.f alpha:alpha]];
    
//    NSLog(@"%f",scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y <= -220) {
        CGRect rect = self.headTopView.frame;
        rect.origin.y = -220+(scrollView.contentOffset.y+220);
        rect.size.height = -scrollView.contentOffset.y;
        self.headTopView.frame = rect;
        self.headTopView.alpha = 1.0f;
        
        CGPoint center = self.headImageView.center;
        center.x = 30;
        center.y = rect.size.height-110;
        self.headImageView.bounds = CGRectMake(0, 0, 50, 50);
        self.headImageView.center = center;
        
    }else{
        self.headTopView.alpha = 1-alpha;
        CGRect rect = self.headTopView.frame;
        rect.origin.y = scrollView.contentOffset.y;
        rect.size.height = -scrollView.contentOffset.y;
        self.headTopView.frame = rect;
//        NSLog(@"%f",self.headTopView.frame.size.height);
        self.headImageView.center = CGPointMake(self.headImageView.center.x, rect.size.height-110);

        CGPoint center = self.headImageView.center;
        center.x = 30;
        center.y = 40 + (220-110-40)*(1-alpha);
        CGFloat width = 30+20*(1-alpha);

        self.headImageView.bounds = CGRectMake(0, 0, width, width);
        self.headImageView.center = center;
    }
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2;
}

@end
