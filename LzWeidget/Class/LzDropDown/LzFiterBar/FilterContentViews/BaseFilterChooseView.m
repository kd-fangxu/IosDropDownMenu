//
//  BaseFilterChooseView.m
//  LzWeidget
//
//  Created by ios开发 on 2017/5/26.
//  Copyright © 2017年 oilchem. All rights reserved.
//

#import "BaseFilterChooseView.h"

@implementation BaseFilterChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentConditionList=[NSMutableArray array];
        self.selectedConditions=[NSMutableArray array];
        _selectedMode=MODE_SingleSelected;
    }
    return self;
}
/**
 查询条件是否选中

 @param conditionStr <#conditionStr description#>

 @return <#return value description#>
 */
- (Boolean)isConditonSelected:(NSString *)conditionStr{
    for (NSString * str in self.selectedConditions) {
        if ([str isEqualToString:conditionStr]) {
            return true;
        }
    }
    return false;
}
@end
