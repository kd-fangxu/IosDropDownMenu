//
//  FilterBarItem.m
//  LzWeidget
//
//  Created by ios开发 on 2016/10/13.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import "FilterBarItem.h"

@implementation FilterBarItem
-(NSInteger)getContentLength{
    NSInteger itemLenth=0;
    if (_title) {
        itemLenth=_title.length;
    }
    if (_rightIconNameNormal&&_rightIconNameSelected) {
        itemLenth=itemLenth+2;
    }
    return itemLenth;

}
@end
