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

    barView=[[lzFilterBarView alloc] initWithOrigin:CGPointMake(0, 100) andHeight:45];
    barView.delegate=self;

    NSMutableArray * datalist=[[NSMutableArray alloc] init];
    FilterBarItem * item=[[FilterBarItem alloc] init];
    [item setTitle:@"test1"];
    [item setRightIconNameNormal:@"test"];
    [item setRightIconNameSelected:@"test"];

    FilterBarItem * item1=[[FilterBarItem alloc] init];
    [item1 setTitle:@"test111111"];
    [item1 setRightIconNameNormal:@"test"];
    [item1 setRightIconNameSelected:@"test"];

    [datalist addObject:item];
    [datalist addObject:item];
    [datalist addObject:item];
    [datalist addObject:item1];




    [self .view addSubview:barView];
    [barView setBarItemList:datalist];
}


-(NSMutableArray *)lzFilterBarView:(lzFilterBarView *)view menuListForItemByTag:(NSString *)itemName{
    NSMutableArray * temAttay=[[NSMutableArray alloc] init];
    NSString * str=@"item";
    [temAttay addObject:@"item1"];
    [temAttay addObject:str];
    [temAttay addObject:str];
    [temAttay addObject:str];
    [temAttay addObject:str];
    [temAttay addObject:str];
    [temAttay addObject:str];

    [temAttay addObject:str];
    [temAttay addObject:str];
    [temAttay addObject:str];

    [temAttay addObject:str];
    [temAttay addObject:str];
    [temAttay addObject:str];

    [temAttay addObject:str];
    [temAttay addObject:str];
    [temAttay addObject:str];

    [temAttay addObject:str];
    [temAttay addObject:str];
    [temAttay addObject:str];

    return temAttay;
}
-(void)onFilterMenuSelected:(NSDictionary *)filterConditionDic{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
