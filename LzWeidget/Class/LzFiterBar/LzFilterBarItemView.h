//
//  LzFilterBarItemView.h
//  LzWeidget
//
//  Created by ios开发 on 2016/10/13.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterBarItem.h"
@interface LzFilterBarItemView : UIView
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UIImageView *rightIv;
@property (nonatomic,strong) FilterBarItem *baritem;

@property (nonatomic, copy) void (^onBarItemClicked)(LzFilterBarItemView * barItemView);

-(instancetype)initWithFrameFilterBarItem:(CGRect)frame Filter:(FilterBarItem *) item;
@end
