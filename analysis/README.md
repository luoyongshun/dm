# UserBehaviorAnalysis
## 【项目环境】
Windows10、Centos7(三集群,三台都为4G，8核)、Idea2019.3、Maven3.3.9、Flink1.7.2、kafka2.11-2.1.0、sacla2.1.18、jdk1.8
## 【项目主要模块】
1. 热门统计

&nbsp;&ensp;&ensp;&ensp;利用用户的点击浏览行为，进行流量统计、近期热门商品统计等。
  
2. 偏好统计 

&nbsp;&ensp;&ensp;&ensp;利用用户的偏好行为，比如收藏、喜欢、评分等，进行用户画像分析，给出个性化的商品推荐列表。

3. 风险控制

&nbsp;&ensp;&ensp;&ensp;利用用户的常规业务行为，比如登录、下单、支付等，分析数据，对异常情况进行报警提示。

4. 说明

&nbsp;&ensp;&ensp;&ensp;本项目限于数据，只实现热门统计和风险控制中的部分内容，将包括以下四大模块：实时热门商品统计、实时流量统计、恶意登录监控和订单支付失效监控。
 
&nbsp;&ensp;&ensp;&ensp;由于对实时性要求较高，用flink作为数据处理的框架。综合运用flink的各种API，基于EventTime去处理基本的业务需求，并且使用底层的processFunction，基于状态编程和CEP去处理更加复杂的情形。

## 【数据源解析】
&nbsp;&ensp;&ensp;&ensp;一共是五份淘宝用户行为数据集，保存为 csv 文件。此数据集包含了淘宝上某一天随机一百万用户的所有行为（包括点击、购买、收藏、喜欢）。数据集的每一行表示一条用户行为，由用户 ID、商品 ID、商品类目 ID、行为类型和时间戳组成，并以逗号分隔，分别保存在每一个分项目的resource中。