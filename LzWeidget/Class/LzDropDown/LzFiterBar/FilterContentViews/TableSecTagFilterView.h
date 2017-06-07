//
//  TableSecTagFilterView.h
//  oil
//
//  Created by ios开发 on 2017/5/27.
//  Copyright © 2017年 隆众资讯技术部. All rights reserved.
//

#import "BaseFilterChooseView.h"
#import "SecTagFilterCell.h"
#import "UIView+Extension.h"
#import "SelectedConditionManager.h"
@interface TableSecTagFilterView : BaseFilterChooseView<UITableViewDelegate,UITableViewDataSource,TTGTextTagCollectionViewDelegate>

@property (nonatomic,strong)  UITableView *tvContent;
//{"name":""
//"child":[
//        {"content"}
//        ]}
@property (nonatomic,strong) NSMutableArray <NSMutableDictionary * > *mDataList;//数据源列表
@property (nonatomic,copy) void (^ controlBtnClickListener)(NSInteger type);//确认1，重置2；
@property (nonatomic,strong) SelectedConditionManager *selectedManager;//选中条件管理者
@end
