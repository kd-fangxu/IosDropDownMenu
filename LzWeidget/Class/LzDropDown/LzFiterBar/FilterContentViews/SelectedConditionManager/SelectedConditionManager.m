//
//  SelectedConditionManager.m
//  oil
//
//  Created by ios开发 on 2017/5/31.
//  Copyright © 2017年 隆众资讯技术部. All rights reserved.
//

#import "SelectedConditionManager.h"

@implementation SelectedConditionManager
-(NSMutableArray *)containerArray{
    if (!_containerArray) {
        _containerArray=[NSMutableArray array];
    }
    return _containerArray;
}

-(void)addConditon:(NSString *)condition in:(NSString *)groupName{

    NSMutableArray * selectedArrayinGroup=[NSMutableArray array];
    int index=[self containerArray].count;
    for (int i=0; i<[self containerArray].count; i++) {
        NSDictionary * dic=[_containerArray objectAtIndex:i];
        if ([[dic objectForKey:@"groupName"] isEqualToString:groupName]) {
            NSArray * temArray=[dic objectForKey:@"selectedConditions"];
            if (temArray!=nil) {
                [selectedArrayinGroup addObjectsFromArray:temArray];
                index=i;
                break;
            }
        }

    }
    [selectedArrayinGroup addObject:condition];
    [self replaceObjectInConditionArray:index withSelectedArray:selectedArrayinGroup groupName:groupName];
}

-(void)clearAll{
    [[self containerArray] removeAllObjects];
}

-(void) removeGroup:(NSString * )groupName{
    int index=[self getIndexInArrayWithGroupName:groupName];
    if ([self containerArray].count>index) {
        [[self containerArray ] removeObjectAtIndex:index];
    }
}

-(void)removeConditon:(NSString *)condition in:(NSString *)groupName{

    NSMutableArray * selectedArrayinGroup=[NSMutableArray array];
    int index=[self containerArray].count;
    for (int i=0; i<[self containerArray].count; i++) {
        NSDictionary * dic=[_containerArray objectAtIndex:i];
        if ([[dic objectForKey:@"groupName"] isEqualToString:groupName]) {
            NSArray * temArray=[dic objectForKey:@"selectedConditions"];
            if (temArray!=nil) {
                [selectedArrayinGroup addObjectsFromArray:temArray];
                index=i;
                for (int j=0;j<temArray.count;j++) {
                    NSString * selName=[temArray objectAtIndex:j];
                    if ([selName isEqualToString:@"condition"]) {
                        [selectedArrayinGroup removeObjectAtIndex:j];
                        break;
                    }
                }
                break;
            }
        }

    }
    [self replaceObjectInConditionArray:index withSelectedArray:selectedArrayinGroup groupName:groupName];
}

-(NSMutableArray *)getConditionsInGroup:(NSString *)groupName{
    for (int i=0; i<[self containerArray].count; i++) {
        NSDictionary * dic=[_containerArray objectAtIndex:i];
        if ([[dic objectForKey:@"groupName"] isEqualToString:groupName]) {
            NSArray * temArray=[dic objectForKey:@"selectedConditions"];
            return temArray;
        }

    }
    return nil;
}

/**
 获取group index

 @param groupName <#groupName description#>

 @return <#return value description#>
 */
-(NSInteger ) getIndexInArrayWithGroupName:(NSString *)groupName{
    NSInteger index=-1;
    for (int i=0; i<[self containerArray].count; i++) {
        NSDictionary * dic=[_containerArray objectAtIndex:i];
        if ([[dic objectForKey:@"groupName"] isEqualToString:groupName]) {
            index=i;
            return index;
        }

    }
    return index;
}
/**
 更新条件列表

 @param index    <#index description#>
 @param selArray <#selArray description#>
 @param name     <#name description#>
 */
-(void) replaceObjectInConditionArray:(NSInteger)index withSelectedArray:(NSMutableArray *) selArray groupName:(NSString *)name{
    NSMutableDictionary * dataDic=[NSMutableDictionary dictionary];
    [dataDic setObject:name forKey:@"groupName"];
    [dataDic setObject: selArray forKey:@"selectedConditions"];
    if ([self containerArray].count>index) {
         [[self containerArray] replaceObjectAtIndex:index withObject:dataDic];
    }else{
        [[self containerArray] addObject:dataDic];
    }

}

-(BOOL)isHasConditionInGroup:(NSString *)groupName with:(NSString *)conditionStr{
    NSArray * array=[self getConditionsInGroup:groupName];
    if (array!=nil) {
        for (NSString * str in array) {
            if ([str isEqualToString:conditionStr]) {
                return true;
            }
        }
    }

    return  false;
}
@end
