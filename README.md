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
<br/>

self.dataSource = [NSMutableArray arrayWithArray:arr];

//历史搜索 。模拟本地数据库里面拿数据

NSArray *historyArr =@[@"蜂飞舞",@"粉丝纷纷",@"发顺丰",@"发顺丰",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞",@"粉丝纷纷",@"fes",@"发顺丰",@"蜂飞舞"];

self.historySource = [NSMutableArray arrayWithArray:historyArr];

_xcLabel = [[XC_label alloc] initWithFrame:CGRectMake(0, 64, LabelScreenW, LabelScreenH-64) AndTitleArr:arr AndhistoryArr:historyArr AndTitleFont:16 AndScrollDirection:UICollectionViewScrollDirectionVertical];
_xcLabel.delegate = self ;

//    _xcLabel.isShow_One = YES ;  //默认NO 显示 
<br/>
//    _xcLabel.isShow_Two = YES ; //默认NO 显示

[self.view addSubview:_xcLabel];
</code>


<h3>
    如果你需要用这个东西的话，只需要下载下来把 XC_Label 拖入工程即可
    详情可参考demo

</h3>



<ol>
<li>实现的思路大概描述一下</li>
<li>写一个标签view xcLabel 然后在view上面添加collectionview 实现collectionview 的代理等。添加代理给xcLabel</li>
<li>给xcLabel 添加代理方法，把点击事件等等 传递出去</li>
<li>声明变量 ，外面可以修改里面局部的东西</li>
<li>mark 这里面最重要的就是 collectionview 的 layout的重写了。 因为 collectionview 他默认居中，自适应cell，导致有的cell很长的时候 会在中间，二边空很多。布局就非常不好看。所以这里 继承 UICollectionViewFlowLayout 重写下了</li>
<li>UICollectionViewFlowLayout 参考 <a href ="http://www.jianshu.com/p/ac3edf92c5fd">参考资料😬</a> -->参考。
</li>

</ol>


</hr>



<ol>
<li>标签小应用 😬😬😬😬</li>
<li>代码比较乱，而且命名不规范，开始是想做一个推荐 和历史搜索页面的，后面稍微扩展了一下，导致里面的名字都是与history等命名的。很多不严谨的地方。</li>
<li>分享出来主要是提供一个思路参考一下。代码不好，请大神勿喷</li>
<li>分享出来主要是提供一个思路参考一下。代码不好，请大神勿喷</li>
<li>分享出来主要是提供一个思路参考一下。代码不好，请大神勿喷</li>
<li>🤗😰🤗</li>

</ol>
