function [p,result,chushi,wen_jiehe]=space_mark_4(A,B,tt,Q1,Q2,Q3,x1)
[n,t]=size(A);
info = zeros(n,t);

for i=1:t
    for j=1:n
        if(A(j,i)<=Q1)
            info(j,i)=1;
        elseif(A(j,i)<=Q2)&&(A(j,i)>Q1)
            info(j,i)=2;
        elseif(A(j,i)<=Q3)&&(A(j,i)>Q2)   
            info(j,i)=3;
        elseif(A(j,i)>Q3)
            info(j,i)=4;
        
        end
    end
end


B=B./repmat(sum(B,2),1,n);
C=B*A;



for i=1:t
    for j=1:n
        if(C(j,i)<=Q1)
            lingyu(j,i)=1;
        elseif(C(j,i)<=Q2)&&(C(j,i)>Q1)
            lingyu(j,i)=2;
        elseif(C(j,i)<=Q3)&&(C(j,i)>Q2)   
            lingyu(j,i)=3;
        elseif(C(j,i)>Q3)  
            lingyu(j,i)=4;
        end
    end
end




for sss=1:4
    for j=1:4
        aa0=0;ab0=0;ac0=0;ad0=0;            
        for ss=1:t-tt   
            info1=info(:,ss);
            info2=info(:,ss+tt);
            
            weizhi2=find(lingyu(:,ss)==sss & info1==j);
            aa=sum(info2(weizhi2)==1);
            ab=sum(info2(weizhi2)==2);
            ac=sum(info2(weizhi2)==3);
            ad=sum(info2(weizhi2)==4);
            
            
            aa0=aa+aa0;
            ab0=ab+ab0;
            ac0=ac+ac0;
            ad0=ad+ad0;
           
        end
        jieguo(j,:,sss)=[aa0 ab0 ac0 ad0 ];
    end
end


res=[jieguo(:,:,1);jieguo(:,:,2);jieguo(:,:,3);jieguo(:,:,4)];

p=[res./repmat(sum(res,2),1,4) sum(res,2)];

p(find(isnan(p)==1)) = 0;

x11 = p

result=[x1;x11];

x12 = x1(:, 1:4);
x112 = x11(:, 1:4);
%% 计算稳态
w_chu =  info(:,1);
w_u = unique(w_chu); 
w_n = hist(w_chu,w_u); 

chushi = w_n/n;  

[V,D] = eig(x12'); % 

[~,idx] = max(diag(D)); 
pi = V(:,idx); 

p_tra = pi/sum(pi); 
w_tra = p_tra';  



w_space = [];
for i = 1:4:16
    kong = x112(i:i+3,:)
    [V,D] = eig(kong'); 
    [~,idx] = max(diag(D)); 
    pi = V(:,idx); 
    w_space1 = pi/sum(pi); 
    w_space1 = w_space1';  
    w_space = [w_space;w_space1]
end

wen_jiehe = [w_tra; w_space]

%%
x12 = repmat(x12,4,1);
ceshi = (x12./x112).^res;
ceshi(find(isnan(ceshi)==1)) = 0.1;
ceshi(ceshi == 0) = 1 ;
sum1 = prod(ceshi(:));
Qb = -2*log(sum1);
df = 36; % 自由度
p_value = chi2cdf(Qb, df, 'upper'); % 计算显著性水平





fprintf('Qb = %f\n', Qb);
fprintf('df = %f\n', df);
fprintf('p-value = %f\n', p_value);





end
