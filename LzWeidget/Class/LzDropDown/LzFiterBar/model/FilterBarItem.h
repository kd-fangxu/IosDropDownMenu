//
//  FilterBarItem.h
//  LzWeidget
//
//  Created by ios开发 on 2016/10/13.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterBarItem : NSObject
@property (nonatomic,strong) NSString  *title;
@property (nonatomic,strong) NSString  *rightIconNameNormal;
@property (nonatomic,strong) NSString  *rightIconNameSelected;


-(NSInteger) getContentLength;
@end
