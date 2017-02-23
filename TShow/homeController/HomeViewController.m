//
//  HomeViewController.m
//  TShow
//
//  Created by 陈锦滔 on 2017/2/22.
//  Copyright © 2017年 陈锦滔. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeCellHeight.h"
#import "HeroModel.h"
#import <MJRefresh/MJRefreshNormalHeader.h>
#import "HomeCellMessage.h"
#import "AndyDropDownList.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,HomeTableViewCellDelegate,AndyDropDownListDelegate>
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) NSMutableDictionary *cellIsShowAll;
@property (strong,nonatomic) AndyDropDownList *andyDropList;
@property (strong,nonatomic) UIButton *titleBtn;
@end

@implementation HomeViewController

- (void)HomeTableViewCellShowContrntWithDic:(NSDictionary *)dic andCellIndexPath:(NSIndexPath *)indexPath{
    [self.cellIsShowAll setObject:[dic objectForKey:@"isShow"] forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"row"]]];
    [self.tableView reloadData];
}

- (void)showMenuList{
    [UIView animateWithDuration:0.3 animations:^{
        _titleBtn.transform=CGAffineTransformMakeScale(1.2,1.2);
    } completion:^(BOOL finished) {
        [_andyDropList showList];
        [UIView animateWithDuration:0.2 animations:^{
            _titleBtn.transform=CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (void)Message:(NSString *)string{
    NSLog(@"%@",string);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self loadDataArray];
    self.cellIsShowAll=[NSMutableDictionary dictionary];
    //下拉显示
    _titleBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _titleBtn.frame=CGRectMake(0, 0,50, self.navigationController.navigationBar.frame.size.height);
    [_titleBtn setTitle:@"我的" forState:UIControlStateNormal];
    [_titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_titleBtn addTarget:self action:@selector(showMenuList) forControlEvents:UIControlEventTouchUpInside];
    UIView *titlesView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,50, self.navigationController.navigationBar.frame.size.height)];
    [titlesView addSubview:_titleBtn];
    self.navigationItem.titleView=titlesView;
    self.andyDropList=[[AndyDropDownList alloc] initWithArray:@[@"好友状态"] frame:CGRectMake(self.view.frame.size.width/6,0,self.view.frame.size.width/1.5 ,50)];
    self.andyDropList.delegate=self;
    [self.tableView addSubview:self.andyDropList];
    //刷新
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh{
    [NSThread sleepForTimeInterval:2];
    [self.tableView.mj_header endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCellMessage *message=[_dataArray objectAtIndex:indexPath.row];
    return [HomeCellHeight cellHeightWithString:message.info andIsShow:[[self.cellIsShowAll objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] boolValue] andLableWidth:[UIScreen mainScreen].bounds.size.width-30 andFont:12 andDefaultHeight:52 andFixedHeight:192 andIsShowBtn:8];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"HomeViewCellId";
    HomeCellMessage *message=[_dataArray objectAtIndex:indexPath.row];
    HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell=[[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId scAdViewArray:message.picArray];
        cell.delegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell setCellContent:message.info andIsShow:[[self.cellIsShowAll objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] boolValue] andCellIndexPath:indexPath andHeadPic:message.headPic andUserName:message.userName andSendTimer:message.sendTimer andsendAddr:message.sendAddr andLoveNum:@"123"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.andyDropList hideList];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView=[[UITableView alloc] init];
        _tableView.frame=self.view.frame;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[[UIView alloc] init];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor colorWithRed:245/255.0 green:212/255.0 blue:217/255.0 alpha:1.0];
    }
    return _tableView;
}

- (void)loadDataArray{
    _dataArray=[NSMutableArray array];
    for(int i=0;i<10;i++){
        HomeCellMessage *message=[[HomeCellMessage alloc] init];
        NSMutableArray *picArrays=[NSMutableArray array];
        
        if(i%2==0){
          message.headPic=@"http://d.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=44efbe491e30e924cff194377c38423e/dcc451da81cb39dbf51ac417d1160924aa18309c.jpg";
          message.sendAddr=@"广州番禺沙湾古镇";
        }else{
          message.headPic=@"http://up.qqjia.com/z/03/tu4511_32.jpg";
          message.sendAddr=@"广东佛山禅城岭南新天地";
        }
    
        message.userName=[NSString stringWithFormat:@"小T.%d",i];
        message.sendTimer=[NSString stringWithFormat:@"2016/09/03/1%d:30",i];
        
        if(i%2==0){
            message.info=@"而服务就开个房hi未公开差距是过节费嘎达是骄傲的很据是否故意给五分与我共分为与恢复噶啥可减肥哈萨克较高的更好看的撒娇规范和骄傲是快递费工商局和开发干烧烤间谍飞哥物业费古二维和法国和看 规划局卡萨发噶烧烤就反感看好几个和会计师法国因为规范业务规范严肃更快捷回复噶啥会计法嘎鱼我一uegfeuawusi很快就挨个送粉红色就爱看个啥尽快发噶山东黄金开发个一uyuwegfduhjkghkasgfaysufgyewugfyuewogf九 嘎哈是控件覆盖赛风购物IE欧GFUI哦噶松德股份哦工行收发货撒旦个一苏打绿发过会儿王力宏。而服务就开个房hi未公开差距是过节费嘎达是骄傲的很据是否故意给五分与我共分为与恢复噶啥可减肥哈萨克较高的更好看的撒娇规范和骄傲是快递费工商局和开发干烧烤间谍飞哥物业费古二维和法国和看 规划局卡萨发噶烧烤就反感看好几个和会计师法国因为规范业务规范严肃更快捷回复噶啥会计法嘎鱼我一uegfeuawusi很快就挨个送粉红色就爱看个啥尽快发噶山东黄金开发个一uyuwegfduhjkghkasgfaysufgyewugfyuewogf九 嘎哈是控件覆盖赛风购物IE欧GFUI哦噶松德股份哦工行收发货撒旦个一苏打绿发过会儿王力宏。";
        }else if(i==5){
            message.info=@"古二维和法国和看 规划局卡萨发噶烧烤就反感看好几个和会计师法国因为规范业务规范严肃更快捷回复噶啥会计法嘎鱼我一uegfeuawusi很快就挨个送粉红色就爱看个啥尽快发噶山东黄金开发个一uyuwegfduhjkghkasgfaysufgyewugfyuewogf九 嘎哈是控件覆盖赛风购物IE欧GFUI哦噶松德股份哦工行收发货撒旦个一苏打绿发过会儿";
        }else if(i==7){
            message.info=@"广东佛山禅城岭南新天地";
        }else{
            message.info=@"you.";
        }
        
        for(int j=0;j<3;j++){
            HeroModel *model=[[HeroModel alloc] init];
            if(j%2==0){
                model.imageName=@"http://pic.58pic.com/58pic/13/87/40/45F58PICswW_1024.jpg";
                model.picTag=i;
                model.introduction=@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487784762703&di=1e08d95b2347493af7450dfeb33c7357&imgtype=0&src=http%3A%2F%2Fpx.thea.cn%2FPublic%2FUpload%2F2844886%2FIntro%2F1456311158.png";
            }else{
                model.imageName=@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487784762703&di=1e08d95b2347493af7450dfeb33c7357&imgtype=0&src=http%3A%2F%2Fpx.thea.cn%2FPublic%2FUpload%2F2844886%2FIntro%2F1456311158.png";
                model.picTag=i;
                model.introduction=@"";
            }
            [picArrays addObject:model];
        }
        message.picArray=picArrays;
        [_dataArray addObject:message];
    }
}



@end
