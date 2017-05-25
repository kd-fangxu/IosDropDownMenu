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
    self=[super initWithOrigin:origin andHeight:height];
    if (self) {
        self.separatorLineWidth=1;
        self.isShown=NO;
        self.selectedMode=MutiSelectedMode;
        self.showMode=collectionViewMode;
        self.conditionContainer=[[FilterConditionContainer alloc] init];
        self.dropDelegate=self;
    }
    return self;
}


-(void) reloadFilterList{
    if (self.currentMenuList==nil) {
        self.currentMenuList=[[NSMutableArray alloc] init];
    }
    [self.currentMenuList removeAllObjects];
    [self.currentMenuList addObjectsFromArray:[self.delegate lzFilterBarView:self menuListForItemByTag:self.currentFilterBarItemView.baritem.title]];
    if (self.showMode==tableViewMode) {
        [self.tableView reloadData];
    }else{
        [self.collectionView reloadData];
    }


}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.delegate) {
        return self.currentMenuList.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * title=[self.currentMenuList objectAtIndex:indexPath.row];
    static NSString *identifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        //cell.separatorInset = UIEdgeInsetsZero;

        cell.textLabel.highlightedTextColor = [UIColor grayColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    if ([self.conditionContainer isMenuListItemSelected:self.currentFilterBarItemView.baritem.title itemName:title]) {
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
    NSString * menuItemTitle=self.currentFilterBarItemView.baritem.title;
    NSString * confitionStr=[self.currentMenuList objectAtIndex:row];

    if ([self.conditionContainer isMenuListItemSelected:menuItemTitle itemName:confitionStr]) {
        if (self.selectedMode==SingleSelectedMode) {
        }else{
            [self.conditionContainer removeConditon:menuItemTitle itemName:confitionStr];
        }
    }else{
        if(self.selectedMode==SingleSelectedMode){
            [self.conditionContainer addContitionSigleModel:menuItemTitle itemName:confitionStr];
        }else{
            [self.conditionContainer addConditons:menuItemTitle itemName:confitionStr];

        }
    }
    NSLog(@"%@", [self.conditionContainer getSelectedMenuListByMenuTitle:menuItemTitle]);
}

#pragma mark collectionViewDelegate




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.currentMenuList count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
};
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString * title=[self.currentMenuList objectAtIndex:indexPath.row];
    filterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"filterCell" forIndexPath:indexPath];
    [cell.btn setTitle:[self.currentMenuList objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell.btn setTag:indexPath.row];
    [cell.btn addTarget:self action:@selector(onCollectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    cell.btn.text=[self.currentMenuList objectAtIndex:indexPath.row];
    if ([self.conditionContainer isMenuListItemSelected:self.currentFilterBarItemView.baritem.title itemName:title]) {
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
    [self.collectionView reloadData];

    [self toggleFilterView];


}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"collection clicked");
    [self doChangeConditon:indexPath.row];
    [collectionView reloadData];

    [self toggleFilterView];

}


#pragma  mark LzDropDownBarDelegate
-(UIView *)LzDropDownBar:(LzDropDownBar *)bar byTitle:(NSString *)menuTitle{
    if (self.showMode==tableViewMode) {
        if (self.tableView==nil) {
            self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,10)];
            [self.tableView setBackgroundColor:[UIColor yellowColor]];
            self.tableView.delegate=self;
            self.tableView.dataSource=self;
            self.tableView.bounces=NO;
        }
        [self reloadFilterList];

      UIView* view=  [[UIView alloc] init];
        view.backgroundColor=[UIColor redColor];
         return  self.tableView;
    }else if(self.showMode==collectionViewMode){
        if (self.collectionView==nil) {
            layout = [[UICollectionViewFlowLayout alloc] init];
            [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
            layout.minimumInteritemSpacing = 5.0f;
            layout.minimumLineSpacing = 1.0f;
            self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,0)collectionViewLayout:layout];
            [self.collectionView setUserInteractionEnabled:YES];
            //         [self.collectView registerClass:[filterCell class] forCellWithReuseIdentifier:reuseIdentifier];
            [self.collectionView registerClass:[filterCell class] forCellWithReuseIdentifier:@"filterCell"];
            self.collectionView.delegate=self;
            self.collectionView.dataSource=self;
            self.collectionView.bounces=NO;
            [self.collectionView setBackgroundColor:[UIColor yellowColor]];

        }
         [self reloadFilterList];
         return  self.collectionView;
    }
    return nil;
};

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        if (self.showMode==tableViewMode) {
            CGPoint tempoint = [self.tableView convertPoint:point fromView:self];
            if (CGRectContainsPoint(self.tableView.bounds, tempoint))
            {
                view = self.tableView;
            }
        }else{
            CGPoint tempoint = [self.collectionView convertPoint:point fromView:self];
            if (CGRectContainsPoint(self.collectionView.bounds, tempoint))
            {
                view = self.collectionView;
            }}
        if (view==nil&&self.isShown) {
            return self.maskView;
            
        }
        
    }
    return view;
}
@end
