//
//  SecTagFilterCell.m
//  oil
//
//  Created by ios开发 on 2017/5/27.
//  Copyright © 2017年 隆众资讯技术部. All rights reserved.
//

#import "SecTagFilterCell.h"

@implementation SecTagFilterCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Alignment
//    _tagView.alignment = TTGTagCollectionAlignmentFillByExpandingWidth;

    // Use manual calculate height
    _tagView.manualCalculateHeight = true;
    //    _tagView.manualCalculateHeight
    TTGTextTagConfig *config = _tagView.defaultConfig;

    _tagView.showsVerticalScrollIndicator=false;
    config.tagTextFont = [UIFont boldSystemFontOfSize:13.0f];

    config.tagTextColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
    config.tagSelectedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.00];

    config.tagBackgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.00];
    config.tagSelectedBackgroundColor = [UIColor colorWithRed:247/255.0 green:41/255.0 blue:27/255.0 alpha:1.00];

    _tagView.horizontalSpacing = 4.0;
    _tagView.verticalSpacing = 3.0;

    config.tagBorderColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.00];
    config.tagSelectedBorderColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
    config.tagBorderWidth = 1;
    config.tagSelectedBorderWidth = 0;

    config.tagShadowColor = [UIColor blackColor];
    config.tagShadowOffset = CGSizeMake(0, 0.2);
    config.tagShadowOpacity = 0.3f;
    config.tagShadowRadius = 0.5f;
    config.tagCornerRadius = 8;
    _tagView.selectionLimit=0;
}

- (void)setTags:(NSArray<NSString *> *)tags {
    [_tagView removeAllTags];
    [_tagView addTags:tags];

    // Use manual height, update preferredMaxLayoutWidth
    _tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 16;

    //    // Random selected
    //    for (NSInteger i = 0; i < 3; i++) {
    //        [_tagView setTagAtIndex:arc4random_uniform((uint32_t)tags.count) selected:YES];
    //    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:false animated:animated];

    // Configure the view for the selected state
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:false animated:animated];
}

@end
