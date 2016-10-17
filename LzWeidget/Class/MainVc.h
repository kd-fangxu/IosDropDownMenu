//
//  MainVc.h
//  LzWeidget
//
//  Created by ios开发 on 2016/10/13.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lzFilterBarView.h"
@interface MainVc : UIViewController <lzFilterBarViewDelegate>{
    lzFilterBarView * barView;
}

@end
