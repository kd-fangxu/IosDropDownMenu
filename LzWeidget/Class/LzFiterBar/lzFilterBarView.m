//
//  lzFilterBarView.m
//  LzWeidget
//
//  Created by ios开发 on 2016/10/13.
//  Copyright © 2016年 oilchem. All rights reserved.
//

#import "lzFilterBarView.h"

@implementation lzFilterBarView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, height)];
    if (self) {
        _separatorLineWidth=1;
        _isShown=NO;
        _selectedMode=MutiSelectedMode;
        _showMode=collectionViewMode;
        _conditionContainer=[[FilterConditionContainer alloc] init];
    }
    return self;
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
                [separatorLineView setBackgroundColor:[UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:0.2]];
                [self addSubview:separatorLineView];
                orignXCursor=CGRectGetMaxX(separatorLineView.frame);
            }
            NSInteger ItemWidth=totalLenth*[item getContentLength]/totalTextLength;
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

-(void) addClickGesture:(UIView *) view{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMaskClick:)];
    //将手势添加到需要相应的view中去
    [view addGestureRecognizer:tapGesture];
    [tapGesture setNumberOfTapsRequired:1];
}
-(void) onMaskClick:(UITapGestureRecognizer *)gesture{
    [self toggleFilterView];
}
-(void)addDataView{

    if(_maskView==nil){
        _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SCREEN_HEIGHT)];
        [_maskView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
        [self addClickGesture:_maskView];
        _maskView.hidden=YES;
    }
    [self addSubview:_maskView];

    if (_showMode==tableViewMode) {
        if (_tableView==nil) {
            _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,10)];
            [_tableView setBackgroundColor:[UIColor yellowColor]];
            _tableView.delegate=self;
            _tableView.dataSource=self;
            _tableView.bounces=NO;
            [self addSubview:_tableView];

        }
    }else if(_showMode==collectionViewMode){
        layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumInteritemSpacing = 5.0f;
        layout.minimumLineSpacing = 1.0f;
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,0)collectionViewLayout:layout];
        [_collectionView setUserInteractionEnabled:YES];
        //         [self.collectView registerClass:[filterCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerClass:[filterCell class] forCellWithReuseIdentifier:@"filterCell"];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.bounces=NO;
        [_collectionView setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:_collectionView];
    }

}

-(void) reloadFilterList{
    if (_currentMenuList==nil) {
        _currentMenuList=[[NSMutableArray alloc] init];
    }
    [_currentMenuList removeAllObjects];
    [_currentMenuList addObjectsFromArray:[_delegate lzFilterBarView:self menuListForItemByTag:_currentFilterBarItemView.baritem.title]];
    if (_showMode==tableViewMode) {
        [_tableView reloadData];
    }else{
        [_collectionView reloadData];
    }


}

-(void)toggleFilterView{
    [UIView animateWithDuration:0.3 animations:^{

    } completion:^(BOOL finished) {
        if (!_isShown) {//显示操作
            [self reloadFilterList];
            [UIView animateWithDuration:0.2 animations:^{
                _maskView.hidden=NO;
                _currentFilterBarItemView.rightIv.transform = CGAffineTransformMakeRotation(M_PI/2);
            }];
            [UIView animateWithDuration:0.4 animations:^{
                if (_showMode==tableViewMode) {
                    _tableView.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, 200);
                }else{
                    _collectionView.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, 200);
                }
                self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+200);

            }];

        }else{//隐藏操作

            self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-200);

            [UIView animateWithDuration:0.1 animations:^{
                if (_showMode==tableViewMode) {
                    _tableView.frame=CGRectMake(0, 0, self.frame.size.width, 0);

                }else{
                    _collectionView.frame=CGRectMake(0, 0, self.frame.size.width, 0);
                }
                _maskView.hidden=YES;
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    _currentFilterBarItemView.rightIv.transform = CGAffineTransformMakeRotation(0);
                    _lastFilterBarItemView.rightIv.transform=CGAffineTransformMakeRotation(0);
                }];
            }];
            
        }
        _isShown=!_isShown;
    }];

}


#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_delegate) {
        return _currentMenuList.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * title=[_currentMenuList objectAtIndex:indexPath.row];
    static NSString *identifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        //cell.separatorInset = UIEdgeInsetsZero;

        cell.textLabel.highlightedTextColor = [UIColor grayColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    if ([_conditionContainer isMenuListItemSelected:_currentFilterBarItemView.baritem.title itemName:title]) {
        [cell.contentView setBackgroundColor:[UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:0.1]];    }else{
            [cell.contentView setBackgroundColor:[UIColor whiteColor]];

        }
    cell.textLabel.text=title;

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self doChangeConditon:indexPath.row];
    [tableView reloadData];
    [self toggleFilterView];
}


-(void) doChangeConditon:(NSInteger *) row{
    NSString * menuItemTitle=_currentFilterBarItemView.baritem.title;
    NSString * confitionStr=[_currentMenuList objectAtIndex:row];

    if ([_conditionContainer isMenuListItemSelected:menuItemTitle itemName:confitionStr]) {
        if (_selectedMode==SingleSelectedMode) {
        }else{
            [_conditionContainer removeConditon:menuItemTitle itemName:confitionStr];
        }
    }else{
        if(_selectedMode==SingleSelectedMode){
            [_conditionContainer addContitionSigleModel:menuItemTitle itemName:confitionStr];
        }else{
            [_conditionContainer addConditons:menuItemTitle itemName:confitionStr];

        }
    }
    NSLog(@"%@", [_conditionContainer getSelectedMenuListByMenuTitle:menuItemTitle]);
}

#pragma mark collectionViewDelegate




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [_currentMenuList count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
};
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString * title=[_currentMenuList objectAtIndex:indexPath.row];
    filterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"filterCell" forIndexPath:indexPath];
    [cell.btn setTitle:[_currentMenuList objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell.btn setTag:indexPath.row];
    [cell.btn addTarget:self action:@selector(onCollectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    cell.btn.text=[_currentMenuList objectAtIndex:indexPath.row];
    if ([_conditionContainer isMenuListItemSelected:_currentFilterBarItemView.baritem.title itemName:title]) {
        [cell.contentView setBackgroundColor:[UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:0.1]];    }else{
            [cell.contentView setBackgroundColor:[UIColor whiteColor]];

        }
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(100, 30);
}
-(void)onCollectBtnClicked:sender{
    UIButton * btn=sender;
    [self doChangeConditon:btn.tag];
    [_collectionView reloadData];

    [self toggleFilterView];


}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"collection clicked");
    [self doChangeConditon:indexPath.row];
    [collectionView reloadData];

    [self toggleFilterView];

}




- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        if (_showMode==tableViewMode) {
            CGPoint tempoint = [_tableView convertPoint:point fromView:self];
            if (CGRectContainsPoint(_tableView.bounds, tempoint))
            {
                view = _tableView;
            }
        }else{
            CGPoint tempoint = [_collectionView convertPoint:point fromView:self];
            if (CGRectContainsPoint(_collectionView.bounds, tempoint))
            {
                view = _collectionView;
            }}
        if (view==nil&&_isShown) {
            return _maskView;

        }

    }
    return view;
}
@end
