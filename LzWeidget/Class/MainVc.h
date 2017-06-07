//
//  MainVc.h
//  LzWeidget
//
//  Created by ios开发 on 2016/10/13.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LzDropDownBar.h"
#import "TableViewFilterView.h"
#import "TableSecTagFilterView.h"
@interface MainVc : UIViewController <LzDropDownBarDelegate>{
    TableViewFilterView * tableFilterView;
    TableSecTagFilterView * tagFilterView;
}
@property (nonatomic,strong)  LzDropDownBar  *dropDownTestBar;
@end
