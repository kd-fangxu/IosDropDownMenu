//
//  FilterConditionContainer.m
//  LzWeidget
//
//  Created by ios开发 on 2016/10/14.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import "FilterConditionContainer.h"

@implementation FilterConditionContainer
- (instancetype)init
{
    self = [super init];
    if (self) {
        _conditonDic=[[NSMutableDictionary alloc] init];
    }
    return self;
}


-(NSMutableArray *) getSelectedMenuListByMenuTitle:(NSString * ) menuTitle{
    return [_conditonDic objectForKey:menuTitle];
}

-(Boolean) isMenuListItemSelected:(NSString *) menuTitle itemName:(NSString *) itemName{
    NSMutableArray * temArray=[self getSelectedMenuListByMenuTitle:menuTitle];
    for (NSString * str in temArray) {
        if ([str isEqualToString:itemName]) {
            return true;
        }
    }
    return  false;
}

-(void) addConditons:(NSString * ) menuTitle itemName:(NSString *) itemName{//多选模式
    NSMutableArray * filterMenus=[_conditonDic objectForKey:menuTitle];
    if (filterMenus==nil) {
        filterMenus=[[NSMutableArray alloc] init];
    }
    [filterMenus addObject:itemName];
    [_conditonDic setObject:filterMenus forKey:menuTitle];
}
-(void) addContitionSigleModel:(NSString *) menuTitle itemName:(NSString *) itemName{//单选添加模式
    NSMutableArray * filterMenus=[[NSMutableArray alloc] init];
    [filterMenus addObject:itemName];
    [_conditonDic setObject:filterMenus forKey:menuTitle];
}
-(void) removeConditon :(NSString *)menuTitle itemName:(NSString *) itemName{
    NSMutableArray * filterMenus=[_conditonDic objectForKey:menuTitle];
    if (filterMenus==nil) {
        return;
    }
    [filterMenus removeObject:itemName];
    
}
@end
