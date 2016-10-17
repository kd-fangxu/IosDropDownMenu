//
//  FilterConditionContainer.h
//  LzWeidget
//
//  Created by ios开发 on 2016/10/14.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterConditionContainer : NSObject
@property (nonatomic,strong) NSMutableDictionary  *conditonDic;

-(NSMutableArray *) getSelectedMenuListByMenuTitle:(NSString * ) menuTitle;
-(Boolean) isMenuListItemSelected:(NSString *) menuTitle itemName:(NSString *) itemName;
-(void) addConditons:(NSString * ) menuTitle itemName:(NSString *) itemName;
-(void) addContitionSigleModel:(NSString *) menuTitle itemName:(NSString *) itemName;
-(void) removeConditon :(NSString *)menuTitle itemName:(NSString *) itemName;
@end
