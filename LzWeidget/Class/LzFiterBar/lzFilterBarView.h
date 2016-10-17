//
//  lzFilterBarView.h
//  LzWeidget
//
//  Created by ios开发 on 2016/10/13.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "filterCell.h"
#import "FilterBarItem.h"
#import "LzFilterBarItemView.h"
#import "FilterConditionContainer.h"

@class lzFilterBarView;
@protocol  lzFilterBarViewDelegate<NSObject>
@required
-(NSMutableArray *)  lzFilterBarView:(lzFilterBarView *) view menuListForItemByTag:(NSString *) itemName;
@required
-(void)onFilterMenuSelected:(NSDictionary *) filterConditionDic;
@end




@interface lzFilterBarView : UIView <UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>{
    UICollectionViewFlowLayout *layout;
}
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

typedef NS_ENUM(NSUInteger,SeletedMode)
{
    SingleSelectedMode,//单选模式 default
    MutiSelectedMode//多选模式

};
typedef NS_ENUM(NSUInteger,ShowMode)
{
    tableViewMode,//单列表模式 default
    collectionViewMode//多列表模式

};

@property (nonatomic,weak) id<lzFilterBarViewDelegate>  delegate;
@property (nonatomic,strong) LzFilterBarItemView *lastFilterBarItemView;//上一个筛选子项view
@property (nonatomic,strong) LzFilterBarItemView *currentFilterBarItemView;//当前筛选子项view
@property (nonatomic,strong) NSMutableArray *currentMenuList;//当前的menu筛选子项

@property (nonatomic,assign) NSInteger separatorLineWidth;//分割线宽度
@property (nonatomic,strong) NSMutableArray *barItemList;
@property (nonatomic,assign) Boolean isShown;

@property (nonatomic,strong) UIView *maskView;//遮罩背景
@property (nonatomic,strong) FilterConditionContainer  *conditionContainer;//条件容器


@property (nonatomic,assign) SeletedMode selectedMode;
@property (nonatomic,assign) ShowMode showMode;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView *collectionView;

- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;

@end
