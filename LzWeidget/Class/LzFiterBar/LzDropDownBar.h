//
//  LzDropDownBar.h
//  LzWeidget
//
//  Created by ios开发 on 2017/5/25.
//  Copyright © 2017年 oilchem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterBarItem.h"
#import "LzFilterBarItemView.h"

@class LzDropDownBar;
@protocol LzDropDownBarDelegate <NSObject>
-(UIView *) LzDropDownBar:(LzDropDownBar *) bar byTitle:(NSString *) menuTitle;
@required


@end

@interface LzDropDownBar : UIView

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


@property (nonatomic,strong) id<LzDropDownBarDelegate>  dropDelegate;

@property (nonatomic,assign) NSInteger separatorLineWidth;//分割线宽度
@property (nonatomic,strong) NSMutableArray *barItemList; //menu数据源
@property (nonatomic,strong) LzFilterBarItemView *lastFilterBarItemView;//上一个筛选子项view
@property (nonatomic,strong) LzFilterBarItemView *currentFilterBarItemView;//当前筛选子项view
@property (nonatomic,strong) UIView  *contentContainer;//内容容器view
@property (nonatomic,assign) int MaxContentHeight;//内容容器的最大高度
@property (nonatomic,assign) Boolean isShown;


@property (nonatomic,strong) UIView *maskView;//遮罩背景

- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;
-(void)toggleFilterView;
@end
