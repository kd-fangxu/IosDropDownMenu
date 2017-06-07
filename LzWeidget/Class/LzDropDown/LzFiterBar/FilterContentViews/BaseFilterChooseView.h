//
//  BaseFilterChooseView.h
//  LzWeidget
//
//  Created by ios开发 on 2017/5/26.
//  Copyright © 2017年 oilchem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoLayout.h"
//#import "FilterConditionContainer.h"

@class  BaseFilterChooseView;
@protocol FilterChooseDelegate <NSObject>

@required

-(void )onConditionSelected:(NSMutableArray *) selectedConditions;//返回选中的条件列表

@end
@interface BaseFilterChooseView : UIView
typedef NS_ENUM(NSUInteger,FilterSeletedMode)
{
    MODE_SingleSelected,//单选模式  default
    MODE_MutiSelectedMode//多选模式

};
@property (nonatomic,strong) id<FilterChooseDelegate> delegate;
@property (nonatomic,assign) FilterSeletedMode selectedMode;
@property (nonatomic,strong) NSMutableArray  *currentConditionList;//筛选条件列表
@property (nonatomic,strong) NSMutableArray  *selectedConditions;//选中的条件列表
//oid (^ itemClickListener)(NSInteger position,NSString * name);
@property (nonatomic,strong) void(^ onConditionClickListener)(NSMutableArray * selectedConditions);//条件点击回调
-(Boolean) isConditonSelected:(NSString *) conditionStr ;
@end
