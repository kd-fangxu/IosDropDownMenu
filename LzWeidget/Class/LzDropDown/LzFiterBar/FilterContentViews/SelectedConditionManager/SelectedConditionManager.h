//
//  SelectedConditionManager.h
//  oil
//
//  Created by ios开发 on 2017/5/31.
//  Copyright © 2017年 隆众资讯技术部. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectedConditionManager : NSObject
//[
//{
//    {"groupName":"groupName"},
//"selectedConditions"
//
// [":"selectedName"}]
// }
// ]
@property (nonatomic,strong) NSMutableArray *containerArray;

-(void)addConditon:(NSString *) condition in: (NSString *) groupName;
-(void)removeConditon:(NSString *) condition in: (NSString *) groupName;
-(NSMutableArray *) getConditionsInGroup:(NSString *) groupName;
-(BOOL) isHasConditionInGroup:(NSString *)groupName with:(NSString *) conditionStr;
-(void) removeGroup:(NSString * )groupName;
-(void) clearAll;
@end
