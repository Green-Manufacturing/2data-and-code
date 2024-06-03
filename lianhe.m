function [x11,result,chushi,wen_jiehe,p_value,local_i,leibie,licha] = lianhe(Y,W,tt,Q1,Q2,Q3,Q4,group,molan)




if (group == 3)
    x1=tra_mark_3(Y,tt,Q1,Q2);
    [x11,result,chushi,wen_jiehe]=space_mark_3(Y,W,tt,Q1,Q2,x1);
    p_value = 0;
    local_i = 0;
    leibie = 0;
    licha = 0;
elseif (group == 4)
    x1=tra_mark_4(Y,tt,Q1,Q2,Q3);
    [x11,result,chushi,wen_jiehe]=space_mark_4(Y,W,tt,Q1,Q2,Q3,x1);
     p_value = 0;
    local_i = 0;
    leibie = 0;
    licha = 0;
elseif (group == 5)&&(molan == 0)
    x1=tra_mark_5(Y,tt,Q1,Q2,Q3,Q4);
    [x11,result,chushi,wen_jiehe]=space_mark_5(Y,W,tt,Q1,Q2,Q3,Q4,x1);
     p_value = 0;
    local_i = 0;
    leibie = 0;
    licha = 0;
elseif (group == 5)&&(molan == 1)
    [p_value,local_i,leibie,licha] = local_mol(Y,W,0.1); %这里可以设置显著性水平
    x1=tra_mark_5(Y,tt,Q1,Q2,Q3,Q4);
    [x11,result,chushi,wen_jiehe]=space_molan_5(Y,W,leibie,tt,Q1,Q2,Q3,Q4,x1);
else    
    x11 = 0;
    result = 0;
    chushi = 0;
    wen_jiehe = 0;
    p_value = 0;
    local_i = 0;
    leibie = 0;
    licha = 0;
    fprintf('\n您设定的模型有误，请调整好参数!\n\n您设定的模型有误，请调整好参数!\n\n您设定的模型有误，请调整好参数!\n');
    return  
end

end

