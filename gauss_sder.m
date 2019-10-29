%readme
%潮流计算
%高斯赛德尔法
%作者:灼眼的kazusa
%时间:2019.10.28
%版本:1.0.1,测试版本,3节点小系统
clc;
clear
close all;
%line_data = [支路号,首端节点号,末端节点号,支路电阻,支路电抗,对地电纳/2]
%line_data = xlsread('线路数据.xlsx');
%line_data = [支路号,首端节点号,末端节点号,支路阻抗,发动机有功,发动机无功,负荷有功,负荷无功];
line_data = [1 1 2 1.05+0i 0.08+0.24i 0  0  0  0
             2 1 3 1.03    0.02+0.06i 0  0  60 25
             3 2 3 0       0.06+0.18i 20 0  50 20];
%计算节点导纳矩阵
YY = zeros(size(line_data,1));
yy = 1./line_data(:,5);
B=line_data(:,2:3);
B(:,3)=yy;
for i = 1:3
    for j=1:3
        if i == j %自导
           YY(i,j)= B(B(i,1),3)+B(B(i,2),3);
        end
        if i < j %互导(没有电纳，实对称矩阵）
           YY(i,j)= -B(i+j-2,3);
           YY(j,i)= YY(i,j);
        end
    end
end %成功求得节点导纳矩阵
%设置初始数据
% U = [1.05 1.03 1.0];
% U2 = U(1,2);
% U3 = U(1,3);
% Q2 = imag(U(1,2)*(YY(:,2)'*conj(U')));%这里不懂为什么YY(:,2)'转置了下就取了共轭了，Amazon！
%sqrt(real(a).^2+imag(a).^2)模的大小 abs angle complex(1,2)
%atan(sqrt(a))*180/pi 幅角大小
%             复数  模  相角
Caculate_v = [1.05 1.05 0
              1.03 1.03 0 
              1.0  1.0  0];%初始电压
%             P  Q  
Caculate_P_Q=[20-50 0 
              -60   -25 ]./100 %化为标幺值
 %计算Q2
Caculate_P_Q(1,2) = imag(Caculate_v(2,1)*(YY(:,2)'*conj(Caculate_v(:,1))));%这里不懂为什么YY(:,2)'转置了下就取了共轭了，Amazon！
%计算u2
t1=Caculate_P_Q(1,1);t2=Caculate_P_Q(1,2);
Caculate_v(2,1)=1./YY(2,2).*(complex(t1,-t2)./conj(Caculate_v(2,1))-YY(2,1).*Caculate_v(1,1)-YY(2,3).*Caculate_v(3,1)); 
%Caculate_v(2,2)保持不变
Caculate_v(2,3)=angle(Caculate_v(2,1));
Caculate_v(2,1)=Caculate_v(2,2)*(complex(cos(Caculate_v(2,3)),sin(Caculate_v(2,3))));
%计算u3
t3=Caculate_P_Q(2,1);t4=Caculate_P_Q(2,2);
Caculate_v(3,1)=1./YY(3,3).*(complex(t3,t4)./conj(Caculate_v(3,1))-YY(3,1).*Caculate_v(1,1)-YY(3,2).*Caculate_v(2,1)); 
%Caculate_v(3,2)保持不变
Caculate_v(3,3)=angle(Caculate_v(3,1));










