//
//  MainVc.m
//  LzWeidget
//
//  Created by ios开发 on 2016/10/13.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import "MainVc.h"

@interface MainVc ()

@end

@implementation MainVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSMutableArray * datalist=[[NSMutableArray alloc] init];

    FilterBarItem * item=[[FilterBarItem alloc] init];
    [item setTitle:@"menu1"];
    [item setRightIconNameNormal:@"test"];
    [item setRightIconNameSelected:@"test"];

    FilterBarItem * item1=[[FilterBarItem alloc] init];
    [item1 setTitle:@"menu2"];
    [item1 setRightIconNameNormal:@"test"];
    [item1 setRightIconNameSelected:@"test"];

    [datalist addObject:item];
    [datalist addObject:item1];
    [datalist addObject:item];
    [datalist addObject:item1];

    _dropDownTestBar=[[LzDropDownBar alloc] initWithOrigin:CGPointMake(0, 100) andHeight:45];
    _dropDownTestBar.dropDelegate=self;
    [_dropDownTestBar setBarItemList:datalist];//加载menu数据
    [self.view addSubview:_dropDownTestBar];

}

-(NSMutableArray *) createTableConditions{
    NSMutableArray * conditionArray=[NSMutableArray array];
    for (int i=0; i<15; i++) {
        [conditionArray addObject:[NSString stringWithFormat:@"condition%d",i]];
    }
    return conditionArray;
}
-(NSMutableArray *) createGroupConditions{
    //{"name":""
    //"child":[
    //        {"content"}
    //        ]}

    NSMutableArray * conditionArray=[NSMutableArray array];
    for (int i=0; i<15; i++) {
        NSMutableDictionary * itemDic=[NSMutableDictionary dictionary];
        [itemDic setObject:[NSString stringWithFormat:@"Group%d",i] forKey:@"name"];
        NSMutableArray * childArray=[NSMutableArray array];
        for (int j=0; j<10; j++) {
            [childArray addObject:[NSString stringWithFormat:@"condition%d",j]];
        }
        [itemDic setObject:childArray forKey:@"child"];
        [conditionArray addObject:itemDic];

    }
    return conditionArray;
}

-(UIView *)LzDropDownBar:(LzDropDownBar *)bar byMenuIndex:(NSInteger)index{
    if (index==0) {
        if (tableFilterView==nil) {
            tableFilterView=[[TableViewFilterView alloc] init];
            [tableFilterView setSelectedMode:MODE_SingleSelected];
            [tableFilterView setCurrentConditionList:[self createTableConditions]];
            [tableFilterView setOnConditionClickListener:^(NSMutableArray * selectedArray){
                NSLog(@"%@", selectedArray);
                [bar toggleFilterView];
            }];
        }
        return tableFilterView;

    }else if (index==1){
        if (tagFilterView==nil) {
            tagFilterView=[[TableSecTagFilterView alloc] init];
            [tagFilterView setMDataList:[self createGroupConditions]];
            [tagFilterView setOnConditionClickListener:^(NSMutableArray * selectedArray){
                NSLog(@"%@", selectedArray);

            }];
        }
        return tagFilterView;

    }
    return nil;
}

@end
