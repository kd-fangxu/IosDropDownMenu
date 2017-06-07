//
//  LzFilterBarItemView.m
//  LzWeidget
//
//  Created by ios开发 on 2016/10/13.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import "LzFilterBarItemView.h"

@implementation LzFilterBarItemView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initWithFrameFilterBarItem:(CGRect)frame Filter:(FilterBarItem *) item{
    self= [self initWithFrame:frame];
    if(self){
        self.userInteractionEnabled=YES;
//        [self setBackgroundColor: [UIColor whiteColor]];
        [self addClickGesture];
        [self setBaritem:item];
    }
    return self;
}
-(void) addClickGesture{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
    //将手势添加到需要相应的view中去
    [self addGestureRecognizer:tapGesture];
    [tapGesture setNumberOfTapsRequired:1];
}
-(void)setOnBarItemClicked:(void (^)(LzFilterBarItemView *))onBarItemClicked{
    _onBarItemClicked=onBarItemClicked;
}
- (void)event:(UITapGestureRecognizer *)gesture{
    NSLog(@"event");
    if(_onBarItemClicked){
        _onBarItemClicked(self);
    }
}
-(void)setBaritem:(FilterBarItem *)baritem{
    _baritem=baritem;
    CGFloat scale=0.7;
    if (!(baritem.rightIconNameNormal&&baritem.rightIconNameSelected)) {
        scale=1.0;
    }
    _title=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.7, self.frame.size.height)];
    _title.text=_baritem.title;
    _title.font=[UIFont systemFontOfSize:14];
    [_title setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_title];
    if (scale<1) {
        CGFloat rightWidth=self.frame.size.width-_title.frame.size.width;
        if (rightWidth>22) {
            rightWidth=22;
        }
        _rightIv=[[UIImageView alloc] initWithFrame:CGRectMake(_title.frame.size.width, (_title.frame.size.height-rightWidth)/2 ,rightWidth , rightWidth)];
        _rightIv.image=[UIImage imageNamed:baritem.rightIconNameNormal];
        _rightIv .contentMode=UIViewContentModeScaleAspectFit;
        [self addSubview:_rightIv];

    }
}
@end
