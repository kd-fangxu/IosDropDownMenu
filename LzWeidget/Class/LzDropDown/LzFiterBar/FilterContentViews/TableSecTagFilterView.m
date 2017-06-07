//
//  TableSecTagFilterView.m
//  oil
//
//  Created by ios开发 on 2017/5/27.
//  Copyright © 2017年 隆众资讯技术部. All rights reserved.
//

#import "TableSecTagFilterView.h"

@implementation TableSecTagFilterView
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
-(void)doInit{
    _tvContent=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //        _tvContent.backgroundColor=[UIColor redColor];
    _tvContent.delegate=  self;
    _tvContent.dataSource=self;

    //_tvContent.tableFooterView
    //        [_tvContent sizeToFit];
    [self addSubview:_tvContent];
    //        _tvContent.tableFooterView=[]
    //        [self addFooterView];
    //        _tvContent.translatesAutoresizingMaskIntoConstraints=YES;
    [self.tvContent autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0,0,0,0)]; //直接设置四周的间隔距离
    _tvContent.estimatedRowHeight = 100;
    _tvContent.rowHeight = UITableViewAutomaticDimension;
    _selectedManager=[[SelectedConditionManager alloc] init];

}
-(void) addFooterView{

    UIView * view=[[UIView alloc ] init];
    UIButton * btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
    btn.backgroundColor=[UIColor redColor];
    [view addSubview:btn];
    _tvContent.tableFooterView=view;
}

-(void)setMDataList:(NSMutableArray<NSMutableDictionary *> *)mDataList{
    _mDataList=mDataList;
    [_tvContent reloadData];
    //    [_tvContent layoutIfNeeded];
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        UIView * view=[[UIView alloc ] initWithFrame:CGRectMake(0, 0, 320, 35)];
        view.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        UIButton * btn=[[UIButton alloc] initWithFrame:CGRectMake(85, 4, 70, 25)];
        btn.titleLabel.textColor=[UIColor whiteColor];
        btn.backgroundColor=[UIColor redColor];
        btn.titleLabel.font=[UIFont systemFontOfSize:13];
        [btn setTitle:@"确认" forState:UIControlStateNormal];
        [view addSubview:btn];

        UIButton * resetBtn=[[UIButton alloc] initWithFrame:CGRectMake(165, 4, 70, 25)];
        resetBtn.titleLabel.textColor=[UIColor whiteColor];
        resetBtn.backgroundColor=[UIColor redColor];
        resetBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [view addSubview:resetBtn];

        [resetBtn addTarget:self action:@selector(onResetClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(onConfirmClicked:) forControlEvents:UIControlEventTouchUpInside];
        return view;
    }
    return nil;
}


-(void)onResetClicked:(UIButton *)sender{
    NSLog(@"onclicked");
    if (_controlBtnClickListener) {
        _controlBtnClickListener(2);
    }
}
-(void)onConfirmClicked:(UIButton *)sender{
    //事件向上传递
    NSLog(@"onclicked");
    if (_controlBtnClickListener) {
        _controlBtnClickListener(1);
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.selectedMode==MODE_MutiSelectedMode) {
        return 35;
    }
    return 0;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return _mDataList.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"SecTagFilterCell";
    SecTagFilterCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil) {
        cell=[[NSBundle mainBundle] loadNibNamed:identify owner:self options:nil][0];
    }
    NSMutableDictionary * itemDic=[_mDataList objectAtIndex:indexPath.row];
    NSString * lbName=[itemDic objectForKey:@"name"];
    NSMutableArray * tags=[itemDic objectForKey:@"child"];
    cell.lb.text=lbName;
    [cell.tagView setTag:indexPath.row];
    [cell setTags:tags];
    if (tags.count>0) {
        [cell.tagView setTagAtIndex:0 selected:false];//让tagview重新计算高度
    }
    NSMutableArray * selectedIndex=[self getSelectedIndexArray:tags withGroupName:lbName];
    for (NSNumber * i in selectedIndex) {
        [cell.tagView setTagAtIndex:i.integerValue selected:YES];
    }

    [cell.tagView sizeToFit];
    //    [cell sizeToFit];
    cell.height=CGRectGetMaxY(cell.tagView.frame)+10;
    //    cell.backgroundColor=[UIColor redColor];
    cell.tagView.delegate=self;
    return cell;
}


/**
 获取选中条件的位置

 @param tags <#tags description#>

 @return <#return value description#>
 */
-(NSMutableArray *) getSelectedIndexArray :(NSMutableArray * )tags withGroupName:(NSString *) groupName{
    NSMutableArray * indexArray=[NSMutableArray array];
    if (_selectedManager) {
        for (int i=0; i<tags.count; i++) {
            NSString * tagStr=[tags objectAtIndex:i];
            if ( [_selectedManager isHasConditionInGroup:groupName with:tagStr]) {
                [indexArray addObject:[[NSNumber alloc] initWithInt:i]];
            }

        }

    }
    return indexArray;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected{
    NSMutableDictionary * itemDic=[_mDataList objectAtIndex:textTagCollectionView.tag];
    NSString * groupName=[itemDic objectForKey:@"name"];
    NSString * conditionStr=tagText;
    if (selected) {
        //        [textTagCollectionView setTagAtIndex:<#(NSUInteger)#> selected:<#(BOOL)#>]

        //1.保存选项

        if (self.selectedMode==MODE_SingleSelected) {

            //            [self.selectedConditions removeAllObjects];
            //            [self.selectedConditions insertObject:conditionStr atIndex:0];

            [_selectedManager clearAll];
            [_selectedManager addConditon:conditionStr in:groupName];
            //            NSLog(@"%@", _selectedManager.containerArray);

        }else if(self.selectedMode==MODE_MutiSelectedMode){
            //
            //            if (![self isConditonSelected:conditionStr]) {
            //                [self.selectedConditions addObject:conditionStr];
            //            }
            [_selectedManager removeGroup:groupName];//多选 组内唯一
            [_selectedManager addConditon:conditionStr in:groupName];//添加条件
            //             NSLog(@"%@", _selectedManager.containerArray);
        }
        //2.设置选项选中
        [_tvContent reloadData];
        //3.将事件向上传递
        if (self.delegate&&[self.delegate respondsToSelector:@selector(onConditionSelected:)]) {
            [self.delegate onConditionSelected:_selectedManager.containerArray];
        }
        if(self.onConditionClickListener){
            self.onConditionClickListener(_selectedManager.containerArray);
        }
    }else{
        [_selectedManager removeConditon:conditionStr in:groupName];
        //        [self.selectedConditions remo]
        //        [self .selectedConditions removeObject:tagText];
    }
    
    
}
@end
