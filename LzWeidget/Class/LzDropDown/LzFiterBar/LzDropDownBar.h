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
@required

/**
 返回menu对应的下拉view

 @param bar <#bar description#>
 @param index <#index description#>
 @return <#return value description#>
 */
-(UIView *) LzDropDownBar:(LzDropDownBar *) bar byMenuIndex:(NSInteger) index;
@optional

/**
 请求menu Index对应的view 刷新数据 （）

 @param bar <#bar description#>
 @param index <#index description#>
 */
-(void) requestViewUpdate:(LzDropDownBar *)bar Index:(NSInteger) index;


@end

@interface LzDropDownBar : UIView

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


@property (nonatomic,strong) id<LzDropDownBarDelegate>  dropDelegate;

@property (nonatomic,assign) NSInteger separatorLineWidth;//分割线宽度

@property (nonatomic,strong) LzFilterBarItemView *lastFilterBarItemView;//上一个筛选子项view
@property (nonatomic,strong) LzFilterBarItemView *currentFilterBarItemView;//当前筛选子项view
@property (nonatomic,strong) UIView  *contentContainer;//内容容器view
@property (nonatomic,assign) int MaxContentHeight;//内容容器的最大高度
@property (nonatomic,assign) Boolean isShown;//显示状态
@property (nonatomic,strong) UIView *maskView;//遮罩背景




@property (nonatomic,strong) NSMutableArray<FilterBarItem *> *barItemList; //menu数据源

- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;
-(void)toggleFilterView;
/**
 设置当前菜单项的显示名称（筛选列表点击后更改）

 @param title <#title description#>
 */
-(void )setCurrentMenuItemViewTitle :(NSString *) title;
@end
