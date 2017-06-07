//
//  TableViewFilterView.m
//  LzWeidget
//
//  Created by ios开发 on 2017/5/26.
//  Copyright © 2017年 oilchem. All rights reserved.
//

#import "TableViewFilterView.h"

@implementation TableViewFilterView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self doInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self doInit];
    }
    return self;
}
-(void) doInit{
    _tvContent=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //        _tvContent.backgroundColor=[UIColor redColor];
    _tvContent.delegate=  self;
    _tvContent.dataSource=self;

    //        [_tvContent sizeToFit];
    [self addSubview:_tvContent];
    //        _tvContent.translatesAutoresizingMaskIntoConstraints=YES;
    [self.tvContent autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0,0,0,0)]; //直接设置四周的间隔距离
}
/**
 设置数据源并显示
 @param currentConditionList <#currentConditionList description#>
 */
- (void)setCurrentConditionList:(NSMutableArray<NSString *> *)currentConditionList{
//    [self.currentConditionList removeAllObjects];
    [super setCurrentConditionList:currentConditionList];
//    [self.currentConditionList addObjectsFromArray:currentConditionList];
    [self.tvContent reloadData];
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentConditionList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * title=[self.currentConditionList objectAtIndex:indexPath.row];
    static NSString *identifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        //cell.separatorInset = UIEdgeInsetsZero;

        cell.textLabel.highlightedTextColor = [UIColor grayColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
        if ([self isConditonSelected:title]) {
            [cell.contentView setBackgroundColor:[UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:0.1]];
        }else{
            [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        }
    cell.textLabel.text=title;

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.保存选项

    NSString * conditionStr=[self.currentConditionList objectAtIndex:indexPath.row];
    if (self.selectedMode==MODE_SingleSelected) {
        [self.selectedConditions removeAllObjects];
        [self.selectedConditions insertObject:conditionStr atIndex:0];
        
    }else if(self.selectedMode==MODE_MutiSelectedMode){
        if (![self isConditonSelected:conditionStr]) {
             [self.selectedConditions addObject:conditionStr];
        }

    }
    //2.设置选项选中
     [tableView reloadData];
    //3.将事件向上传递
    if (self.delegate&&[self.delegate respondsToSelector:@selector(onConditionSelected:)]) {
        [self.delegate onConditionSelected:self.selectedConditions];
    }
    if(self.onConditionClickListener){
        self.onConditionClickListener(self.selectedConditions);
    }
}



@end
