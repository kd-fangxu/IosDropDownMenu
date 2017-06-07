//
//  SecTagFilterCell.h
//  oil
//
//  Created by ios开发 on 2017/5/27.
//  Copyright © 2017年 隆众资讯技术部. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGTextTagCollectionView.h"
@interface SecTagFilterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet TTGTextTagCollectionView *tagView;
- (void)setTags:(NSArray <NSString *> *)tags;
@end
