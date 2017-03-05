//
//  AndyDropDownList.m
//  ButtonMenu
//
//  Created by 陈锦滔 on 2017/2/20.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "AndyDropDownList.h"

@interface AndyDropDownList()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSArray *arrayList;
@property (strong,nonatomic) UITableView *tableView;
@end

@implementation AndyDropDownList

- (instancetype)initWithArray:(NSArray *)arrays frame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        _arrayList=arrays;
    }
    return self;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView=[[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor=[[UIColor orangeColor] colorWithAlphaComponent:0.8];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.backgroundColor=[UIColor whiteColor];
    }
    return _tableView;
}

- (void)showList{
    [self addSubview:self.tableView];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.25f animations:^{
        self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, 50 * _arrayList.count);
    }];
}

- (void)hideList{
    [UIView animateWithDuration:0.25f animations:^{
        self.tableView.frame = CGRectMake(0, 0, self.frame.size.width,0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identity=@"idCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identity];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identity];
    }
    cell.textLabel.text=[_arrayList objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    //划线至左端
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.backgroundColor=[UIColor colorWithRed:249/255.0 green:205/255.0 blue:173/255.0 alpha:0.8];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self hideList];
    if([self.delegate respondsToSelector:@selector(Message:)]){
        [self.delegate Message:_arrayList[indexPath.row]];
    }
}


@end
