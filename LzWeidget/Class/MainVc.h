//
//  MainVc.h
//  LzWeidget
//
//  Created by ios开发 on 2016/10/13.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LzDropDownBar.h"
#import "lzFilterBarView.h"
@interface MainVc : UIViewController <lzFilterBarViewDelegate,LzDropDownBarDelegate>{
    lzFilterBarView * barView;
}
@property (nonatomic,strong)  LzDropDownBar  *dropDownTestBar;
@end
