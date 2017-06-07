//
//  TableViewFilterView.h
//  LzWeidget
//
//  Created by ios开发 on 2017/5/26.
//  Copyright © 2017年 oilchem. All rights reserved.
//

#import "BaseFilterChooseView.h"

@interface TableViewFilterView : BaseFilterChooseView <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  UITableView *tvContent;
@end
