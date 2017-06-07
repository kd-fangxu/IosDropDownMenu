//
//  LzDropDownBar.m
//  LzWeidget
//
//  Created by ios开发 on 2017/5/25.
//  Copyright © 2017年 oilchem. All rights reserved.
//

#import "LzDropDownBar.h"

@implementation LzDropDownBar

-(instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, height)];
    if (self) {
        _separatorLineWidth=2;
        _MaxContentHeight=(NSInteger)screenSize.height*2/3;
        //        _isShown=NO;
        //        _selectedMode=MutiSelectedMode;
        //        _showMode=collectionViewMode;
        //        _conditionContainer=[[FilterConditionContainer alloc] init];
    }
    return self;

}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)addDataView{

    if(_maskView==nil){
        _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, SCREEN_HEIGHT)];
        [_maskView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
        [self addClickGesture:_maskView];
        _maskView.hidden=YES;
    }
    [self addSubview:_maskView];
    //     _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,10)];
    _contentContainer=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    [self addSubview:_contentContainer];

}
-(void) addClickGesture:(UIView *) view{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMaskClick:)];
    //将手势添加到需要相应的view中去
    [view addGestureRecognizer:tapGesture];
    [tapGesture setNumberOfTapsRequired:1];
}
-(void) onMaskClick:(UITapGestureRecognizer *)gesture{
    [self toggleFilterView];
}

-(void)setContentContainer:(UIView *)contentContainer{
    _contentContainer.removeFromSuperview;
    _contentContainer=contentContainer;
    _contentContainer.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, 0);
    [self insertSubview:_contentContainer aboveSubview:_maskView];

    //[self addSubview:_contentContainer];
}

/**
 menu Item 点击事件

 @param menuItemView <#menuItemView description#>
 */
-(void) onMenuItemViewClicked:(LzFilterBarItemView *) menuItemView{
    NSInteger  index=menuItemView.tag;
    if (_currentFilterBarItemView) {
        _lastFilterBarItemView=_currentFilterBarItemView;
        _currentFilterBarItemView=menuItemView;
    }else{
        _currentFilterBarItemView=menuItemView;
        _lastFilterBarItemView=_currentFilterBarItemView;
    }
    if (_isShown) {
        [self toggleFilterView];
        return;
    }

    if (_dropDelegate&& ([_dropDelegate respondsToSelector:@selector( LzDropDownBar:byMenuIndex:)])) {
        [self setContentContainer:[_dropDelegate LzDropDownBar:self byMenuIndex:index]];
        if (self.dropDelegate&&[self.dropDelegate respondsToSelector:@selector(requestViewUpdate:)]) {
            [self.dropDelegate requestViewUpdate:self Index:index];
        }
        [self toggleFilterView];
    }

}

-(void)setCurrentMenuItemViewTitle:(NSString *)title{
    _currentFilterBarItemView.title.text=title;
    _currentFilterBarItemView.baritem.title=title;
}

-(void)setBarItemList:(NSMutableArray *)barItemList{
    _barItemList=barItemList;
    [self addDataView];
    if (_barItemList.count>0) {
        NSInteger totalLenth=SCREEN_WIDTH-(_barItemList.count-1)*_separatorLineWidth;
        NSInteger totalTextLength=0;
        for (FilterBarItem * item in _barItemList) {
            totalTextLength=totalTextLength+item.getContentLength;
        }

        NSInteger  orignXCursor=0;
        for (int i=0; i<_barItemList.count; i++) {
            FilterBarItem * item=[_barItemList objectAtIndex:i];
            if (i>0) {
                UIView * separatorLineView=[[UIView alloc] initWithFrame:CGRectMake(orignXCursor, self.frame.size.height/4, _separatorLineWidth, self.frame.size.height/2)];
                [separatorLineView setBackgroundColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0]];
                [self addSubview:separatorLineView];
                orignXCursor=CGRectGetMaxX(separatorLineView.frame);
            }
            NSInteger ItemWidth=totalLenth*[item getContentLength]/totalTextLength;
            if(i==(_barItemList.count-1)){//最后一项宽度用于补齐
                ItemWidth=self.frame.size.width-orignXCursor;
            }
            LzFilterBarItemView *itemView=[[LzFilterBarItemView alloc] initWithFrameFilterBarItem:CGRectMake(orignXCursor, 0, ItemWidth, self.frame.size.height) Filter:item];
            itemView.backgroundColor=self.backgroundColor;
            [itemView setTag:i];
            [itemView setOnBarItemClicked:^(LzFilterBarItemView * itemView) {
                [self onMenuItemViewClicked:itemView];
            }];
            [self addSubview:itemView];
            orignXCursor=CGRectGetMaxX(itemView.frame);

        }
    }

}


/**
 显示开关
 */
-(void)toggleFilterView{
    //    self.backgroundColor=[UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{

    } completion:^(BOOL finished) {
        if (!_isShown) {//显示操作
            [_contentContainer layoutSubviews];//约束和动画的冲突 尼玛要加上这句
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                _currentFilterBarItemView.rightIv.transform = CGAffineTransformMakeRotation(M_PI);
                _contentContainer.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, (double)_MaxContentHeight);
                _maskView.hidden=NO;
                _maskView.backgroundColor=[UIColor colorWithRed:235/255 green:235/255 blue:235/255 alpha:0.2];
            } completion:^(BOOL finished) {
                self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+_MaxContentHeight);//保证下拉子view的焦点位于父view内
            }];
        }else{//隐藏操作
            self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-_MaxContentHeight);
             [_contentContainer layoutSubviews];//约束和动画的冲突 尼玛要加上这句
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                _contentContainer.frame=CGRectMake(0,self.frame.size.height, self.frame.size.width,0);
                _currentFilterBarItemView.rightIv.transform = CGAffineTransformMakeRotation(0);
                _lastFilterBarItemView.rightIv.transform=CGAffineTransformMakeRotation(0);
                _maskView.backgroundColor=[UIColor colorWithRed:235/255 green:235/255 blue:235/255 alpha:0];
            } completion:^(BOOL finished) {
                _maskView.hidden=YES;

            }];

        }
        _isShown=!_isShown;
    }];

}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        if (view==nil&&_isShown) {
            return _maskView;
        }
    }
    return view;
}
@end
