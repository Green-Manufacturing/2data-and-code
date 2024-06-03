function [p_value,local_i,leibie,licha] = local_mol(Y,W,pp1)
%UNTITLED3 此处显示有关此函数的摘要
[N,T]= size(Y);
W3 = sum(W,2);
W4 = repmat(W3,1,N);
W = W./W4;
W5 = sum(W,2);
for i = 1:N;
    W6(i) = round(W5(i));
end
if round(W6)==ones(N,1);
    ('Your spatial weight matrix has been row standarded.')
else
    ('Your spatial weight matrix needs to be row standarded.')
end

p_value = [];
local_i = [];
licha1 = mean(Y);
licha = Y - repmat(licha1,N,1);

for j = 1:T
    
    Y1 = Y(:,j);
    
    Y1_mean = repmat(mean(Y1),N,1);
    
    YY = Y1-Y1_mean;  
    
    vm2 = YY.^2; 
    vm4 = YY.^4; 
    vm2_mean = mean(vm2);
    
    b2 = mean(vm4)/(mean(vm2)^2);  
    wi = sum(W,2); 
    W111 = W.^2
    wi2 = sum(W111,2); 
    stat = [];
    E = [];
    sd = [];
    z = [];
    p = [];
    for i = 1 : N      
        stat1 = YY(i,1)/vm2_mean*(W(i,:)*YY)
        stat = [stat;stat1]
        
        E1 = (-wi(i,1))/(N-1)
        E = [E;E1]
        
        T1 = (wi2(i,1)*(N-b2))/(N-1);
        
        T2 = ((wi(i,1)^2-wi2(i,1))*(2*b2-N))/((N-1)*(N-2));
        
        T3 = ((-wi(i,1))/(N-1))^2;
        sd12 = T1 + T2 - T3;
        sd1 = sqrt(sd12);
        
        sd = [sd;sd1];
        
        z1 = (stat1-E1)/sd1;
        z = [z;z1];
        
        p1 = (1-normcdf(abs(z1),0,1))*2;
        p = [p;p1];
        
    end
   p_value = [p_value,p]; 
   local_i = [local_i,stat];
    
end
% [stat,E,sd,z,p]


leibie = []


for i = 1:N
    for j = 1:T
        if (p_value(i,j)>pp1)
            leibie(i,j) = 5 ;
        elseif (licha(i,j)>0 && local_i(i,j)>0)
            leibie(i,j) = 1;
        elseif (licha(i,j)<0 && local_i(i,j)<0)
            leibie(i,j) = 2;
        elseif (licha(i,j)<0 && local_i(i,j)>0)
            leibie(i,j) = 3;
        elseif (licha(i,j)>0 && local_i(i,j)<0)
            leibie(i,j) = 4;
        end
    end
    
end

end

