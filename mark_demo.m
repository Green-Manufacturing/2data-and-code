
clc;
clear;

%% 导入数据并设置对应参数！！

cd('C:\Users\86178\OneDrive\桌面\论文修改\第二篇文章修改\马尔可夫模型'); % 根据实际情况修改，设置工作路径。
Y = xlsread('测试数据.xlsx'); % 导入数据
W = xlsread('空间权重矩阵.xlsx'); % 导入空间权重矩阵
save('example','Y','W');

load('example.mat');

group= 4  ;  %分组个数，可分3、4、5组。记得同步修改分位数节点。

quant =0  ; %填0或者1。（0代表自动根据分位数计算，1代表需要自定义临界点）。

molan =0  ; %若填1则代表根据：高高集聚、低低集聚类型来计算空间马尔科夫转移矩阵。若填0，则代表根据分位数计算空间马尔科夫转移矩阵。



T=1; %跨期数。

%% 

if ((group==3)&&(quant==0))
    q = quantile(reshape(Y, 1, []), [0.33 0.66]);
    Q1 = q(1,1);Q2 = q(1,2);Q3 = 0;Q4 = 0;
elseif ((group==4)&&(quant==0))
    q = quantile(reshape(Y, 1, []), [0.25 0.5 0.75]);
    Q1 = q(1,1);Q2 = q(1,2);Q3 = q(1,3);Q4 = 0;
elseif ((group==5)&&(quant==0))    
    q = quantile(reshape(Y, 1, []), [0.20 0.40 0.60 0.80]);
    Q1 = q(1,1);Q2 = q(1,2);Q3 = q(1,3);Q4 = q(1,4);
else
    ;  %空语句    
end  
[x11,result,chushi,wen_jiehe,p_value,local_i,leibie,licha]=lianhe(Y,W,T,Q1,Q2,Q3,Q4,group,molan);




