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
        _separatorLineWidth=1;
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
        _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SCREEN_HEIGHT)];
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
    _contentContainer.frame=CGRectMake(0, 0, self.frame.size.width, 0);
    [self insertSubview:_contentContainer aboveSubview:_maskView];
    //    [self addSubview:_contentContainer];
}
-(void) toggleView:(UIView *) contentView{
    [self setContentContainer:contentView];
    [self toggleFilterView];
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
                UIView * separatorLineView=[[UIView alloc] initWithFrame:CGRectMake(orignXCursor, 5, _separatorLineWidth, self.frame.size.height-10)];
                [separatorLineView setBackgroundColor:[UIColor colorWithRed:235/255 green:235/255 blue:235/255 alpha:1]];
                [self addSubview:separatorLineView];
                orignXCursor=CGRectGetMaxX(separatorLineView.frame);
            }
            NSInteger ItemWidth=totalLenth*[item getContentLength]/totalTextLength;
            if(i==(_barItemList.count-1)){//最后一项宽度用于补齐
                ItemWidth=self.frame.size.width-orignXCursor;
            }
            LzFilterBarItemView *itemView=[[LzFilterBarItemView alloc] initWithFrameFilterBarItem:CGRectMake(orignXCursor, 0, ItemWidth, self.frame.size.height) Filter:item];

            [itemView setOnBarItemClicked:^(LzFilterBarItemView * itemView) {
                if (_currentFilterBarItemView) {
                    _lastFilterBarItemView=_currentFilterBarItemView;
                    _currentFilterBarItemView=itemView;
                }else{
                    _currentFilterBarItemView=itemView;
                    _lastFilterBarItemView=_currentFilterBarItemView;
                }
                [self toggleFilterView];
            }];
            [self addSubview:itemView];
            orignXCursor=CGRectGetMaxX(itemView.frame);

        }
    }

}


-(void)toggleFilterView{
    [UIView animateWithDuration:0.3 animations:^{

    } completion:^(BOOL finished) {
        if (!_isShown) {//显示操作
            //            [self reloadFilterList];
            if (_dropDelegate&&[_dropDelegate respondsToSelector:@selector(LzDropDownBar:byTitle:)]) {
                [ self setContentContainer:[_dropDelegate LzDropDownBar:self byTitle:_currentFilterBarItemView.baritem.title]];
            }
            [UIView animateWithDuration:0.4 animations:^{
                _maskView.hidden=NO;
                _currentFilterBarItemView.rightIv.transform = CGAffineTransformMakeRotation(M_PI);
                _contentContainer.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, (double)_MaxContentHeight);

            } completion:^(BOOL finished) {
                self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+_MaxContentHeight);//保证下拉子view的焦点位于父view内
            }];

        }else{//隐藏操作

            self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-_MaxContentHeight);

            [UIView animateWithDuration:0.4 animations:^{
                _contentContainer.frame=CGRectMake(0, 0, self.frame.size.width, 0);
                _maskView.hidden=YES;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    _currentFilterBarItemView.rightIv.transform = CGAffineTransformMakeRotation(0);
                    _lastFilterBarItemView.rightIv.transform=CGAffineTransformMakeRotation(0);
                }];
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
