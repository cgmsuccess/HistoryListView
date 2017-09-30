# HistoryListView
几句代码快速创建 有推荐和历史 搜索的 页面
<h1>效果图</h1>
<img src = "https://github.com/cgmsuccess/HistoryListView/blob/master/test.gif">效果图</ima>

<h3>具体使用方法，在 viewController里面 </h3>

<h3>在外面操作数据，本地历史 和 网络数据，分别为historySource ，dataSource</h3>

<h3>我们只需要操作外面的数据，页面也会随之改变，通过代理方法，页面把对应数据反传回来，然后在
操作，历史数据等
</h3>
</hr>
<h1>6句代码就可以创建标签页面，遵循代理实现3个代理即可</h1>
<code> //推荐搜索 ，模拟网络数据
NSArray *arr = @[@"fes4发发ewrew",@"发顺丰",@"飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺发丰",@"蜂飞舞",@"粉丝发发发发发纷",@"fes",@"发发发顺丰",@"蜂发飞舞",@"粉发发发丝发纷纷",@"发发fes",@"发顺丰",@"蜂飞发舞",@"发",@"粉丝粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷粉丝纷纷"];

self.dataSource = [NSMutableArray arrayWithArray:arr];
//历史搜索 。模拟本地数据库里面拿数据
NSArray *historyArr =@[@"蜂飞舞",@"粉丝纷纷",@"发顺丰",@"发顺丰",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞"];
self.historySource = [NSMutableArray arrayWithArray:historyArr];

_xcLabel = [[XC_label alloc] initWithFrame:CGRectMake(0, 64, LabelScreenW, LabelScreenH-64) AndTitleArr:arr AndhistoryArr:historyArr AndTitleFont:16 AndScrollDirection:UICollectionViewScrollDirectionVertical];
_xcLabel.delegate = self ;

//    _xcLabel.isShow_One = YES ;  //默认NO 显示
//    _xcLabel.isShow_Two = YES ; //默认NO 显示

[self.view addSubview:_xcLabel];
</code>

